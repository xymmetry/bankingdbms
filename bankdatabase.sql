/*
CCPS510 Bank Database

Developed by:
Tushar Chadha, Marc David, John Dixon, Abhinav Paturi
*/


CREATE TABLE bank(
  bankID INT NOT NULL,
  name VARCHAR(25) NOT NULL,
  address varchar(25) NOT NULL,
  branchID INT,
  PRIMARY KEY (bankID),
  FOREIGN KEY (branchID) REFERENCES Branch(branchID)
  CONSTRAINT UC_Bank UNIQUE (bankID)
  );

CREATE TABLE Branch(
	branchID INT,
  name VARCHAR(20) NOT NULL,
  address VARCHAR(50) NOT NULL,
  bankID INT,
  PRIMARY KEY (branchID),
  FOREIGN KEY (bankID) REFERENCES bank(bankID)
  CONSTRAINT UC_Branch UNIQUE (branchID)
  );

CREATE TABLE Account(
	accountID INT,
  totalbal INT,
  name VARCHAR(20) NOT NULL,
  sinNum INT, 
  PRIMARY KEY (accountID),
  FOREIGN KEY (sinNum) 
  REFERENCES Customer(sinNum)
  CONSTRAINT UC_Account UNIQUE (AccountID)
  );

CREATE TABLE Loan(
	loanID INT,
  type VARCHAR(20) NOT NULL,
  accountID INT,
  PRIMARY KEY (loanID),
  FOREIGN KEY (accountID) REFERENCES Account(accountID)
  CONSTRAINT UC_Loan UNIQUE (loanID)
);

CREATE TABLE Mortgage(
	downpayment INT,
  price INT,
  type VARCHAR(20) NOT NULL,
  loanID INT,
  pay INT,
  PRIMARY KEY (loanID),
  FOREIGN KEY (loanID) REFERENCES Loan(loanID)  
);

CREATE TABLE lineofcredit(
  locID INT,
  lclimit INT,
  business VARCHAR(25),
  mortgage INT,
  personel VARCHAR(25),
  interestRate INT,
  LoanID INT,
  PRIMARY KEY (locID),
  FOREIGN KEY (LoanID) REFERENCES Loan(loanID)
);

CREATE TABLE chequingAcc(
  cheqID INT,
  cardnum INT,
  balance INT default 0,
  overdraft boolean default false,
  expiry DATE,
  accountID INT,
  PRIMARY KEY (cheqID),
  FOREIGN KEY (accountID) REFERENCES Account(accountID)
);

CREATE TABLE creditCard(
  cardNumber INT,
  expiryDate DATE,
  ccLimit INT,
  cardType VARCHAR(25),
  accountID INT,
  PRIMARY KEY (cardNumber),
  FOREIGN KEY (accountID) REFERENCES Account(accountID)
);

CREATE TABLE savings(
  accNo INT,
  balance INT DEFAULT 0,
  interestRate INT,
  accountID INT,
  deposit INT, 
  withdrawal INT, 
  PRIMARY KEY (accNo),
  FOREIGN KEY (accountID) REFERENCES Account(accountID)
  CONSTRAINT CHK_dep CHECK (deposit > 0 ) 
  
);


CREATE TABLE overdraft(
  overdraftID INT,
  cheqID INT,
  overdraft boolean default false,
  PRIMARY KEY (overdraftID),
  FOREIGN KEY (cheqID) REFERENCES chequingAcc(cheqID)
);


CREATE TABLE Customer(
  sinNum INT NOT NULL,
  age INT NOT NULL,
  phoneNum INT NOT NULL,
  firstName VARCHAR(25) NOT NULL,
  lastName VARCHAR(25) NOT NULL,
  province VARCHAR(5) NOT NULL,
  street VARCHAR(25) NOT NULL,
  city VARCHAR(25) NOT NULL,
  zip VARCHAR(8) NOT NULL,
  accountID INT,
  PRIMARY KEY (sinNum),
  FOREIGN KEY (accountID) REFERENCES Account(accountID) 
  ON UPDATE CASCADE ON DELETE CASCADE
  CONSTRAINT CHK_phoneNum CHECK (phoneNum >= 100000000 and phoneNum <= 9999999999 )
  CONSTRAINT CHK_age CHECK (age >= 16 and age <= 140 )
  CONSTRAINT CHK_zip CHECK (LENGTH(zip) == 6 ) 
);

CREATE TABLE trans(
  trID INT NOT NULL,
  accountID INT NOT NULL,
  type VARCHAR(10),
  amount INT, 
  tdate DATE,
  PRIMARY KEY (trID),
  FOREIGN KEY (accountID) REFERENCES Account(accountID)
);


CREATE TRIGGER newBANK AFTER INSERT ON branch
  BEGIN
    update bank set branchID = NEW.branchID WHERE bank.bankID = NEW.bankId;
END; 

CREATE TRIGGER newAcc AFTER INSERT ON Account
Begin
    update Customer set accountID = NEW.accountID WHERE Customer.sinNum = NEW.sinNum;
END;
