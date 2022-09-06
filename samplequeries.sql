INSERT INTO bank (bankId, name, address, branchID) values (1,'TD','52 Peel Centre Drive', 22);

INSERT INTO Branch (branchID, name, address, bankID) values (22, 'Brampton Branch', '52 Peel Centre Drive', 1);

INSERT INTO Customer (sinNum, age, phoneNum, firstName, lastName, province, street, city, zip) values (123456890, 20, 416000000, 'Yer', 'Boi', 'ON', '2 Bramalea Street', 'Brampton', 'L3V2S2'); 

INSERT INTO Account (accountID, totalbal, name, sinNum) values (15, 0, 'Main Account', 123456890);

INSERT INTO Loan (loanID, type, accountID) values (123, 'I O U', 15);

INSERT INTO Mortgage (downpayment, price, type, loanID, pay) values (5000, 250000, 'My house', 123, 2000);

INSERT INTO lineofcredit (locID, lclimit, business, mortgage, personel, interestRate, LoanID) values (9, 5000, 'Bidness', 500000, 'da plug', 5, 123);

INSERT INTO chequingAcc (cheqID, cardnum, balance, overdraft, expiry, accountID) values (456, 111222333, 2000, false,'2025-10-10', 15);

INSERT INTO creditcard (cardNumber, expirydate, ccLimit, cardType, accountID) values (222333444, '2025-10-10', 5000, 'AMEX', 15);

INSERT INTO savings (accNo, balance, interestRate, accountID, deposit, withdrawal) values (900, 3000, 1, 15, 5, 0);

INSERT INTO overdraft (overdraftID, cheqID, overdraft) values (1111, 456, false);

INSERT INTO trans (trID, accountID, type, amount, tdate) values (69, 15, 'Mortgage', 5000, DATE('NOW'));

INSERT INTO trans (trID, accountID, type, amount, tdate) values (70, 15, 'lineofcredit', 2000, DATE('NOW'));

INSERT INTO trans (trID, accountID, type, amount, tdate) values (71, 15, 'Overdraft', 100, DATE('NOW'));

SELECT amount FROM trans WHERE amount > 200 GROUP BY trID;
