-- Jinho Nam & Brady Wheelhouse

-- Part 3. DDL commands

    -- Drop tables and their constraints
    DROP TABLE transaction CASCADE CONSTRAINTS;
    DROP TABLE sender CASCADE CONSTRAINTS;
    DROP TABLE receiver CASCADE CONSTRAINTS;
    DROP TABLE client_benefit CASCADE CONSTRAINTS;
    DROP TABLE benefits CASCADE CONSTRAINTS;
    DROP TABLE client CASCADE CONSTRAINTS;
    DROP TABLE card CASCADE CONSTRAINTS;
    DROP TABLE bankaccount CASCADE CONSTRAINTS;

    -- Drop sequences for primary keys of bankaccount and card tables
    DROP SEQUENCE accountid_seq;
    DROP SEQUENCE cardid_seq;

    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------

    -- TABLE 1: bankaccount
    CREATE SEQUENCE accountid_seq -- create sequnce for primary key
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 5
    NOCACHE;

    CREATE TABLE bankaccount (
        accountid     NUMBER(3) CONSTRAINT bankaccount_pk PRIMARY KEY,
        accountnumber NUMBER(17) NOT NULL
    );
    ALTER TABLE bankaccount ADD CONSTRAINT accountnum_unique UNIQUE(accountnumber);

    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------

    -- TABLE 2: benefits
    CREATE TABLE benefits (
        benefitid NUMBER(2) CONSTRAINT benefits_pk PRIMARY KEY,
        benefit_desc VARCHAR(25)
    );

    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------

    -- TABLE 3: card
    CREATE SEQUENCE cardid_seq -- create sequnce for primary key
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 5
    NOCACHE;

    CREATE TABLE card (
        cardid     NUMBER(4) CONSTRAINT card_pk PRIMARY KEY,
        cardnumber NUMBER(16) NOT NULL
    );
    ALTER TABLE card ADD CONSTRAINT cardnum_unique UNIQUE(cardnumber);

    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------

    -- TABLE 4: client
    CREATE TABLE client (
        clientid      NUMBER(3) NOT NULL,
        clientlast    VARCHAR2(25) NOT NULL,
        clientfirst   VARCHAR2(25) NOT NULL,
        balance       NUMBER(10, 2) NOT NULL,
        phone         CHAR(10) NOT NULL,
        streetaddress VARCHAR2(30) NOT NULL,
        state         CHAR(2) NOT NULL,
        email         VARCHAR2(30)
    );
    ALTER TABLE client ADD CONSTRAINT client_pk PRIMARY KEY ( clientid );

    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------

    -- TABLE 5: client_benefit
    CREATE TABLE client_benefit (
        benefitstartdate   DATE NOT NULL,
        benefits_benefitid NUMBER(2) NOT NULL,
        client_clientid    NUMBER(3) NOT NULL
    );
    ALTER TABLE client_benefit ADD CONSTRAINT client_benefit_pk PRIMARY KEY ( benefits_benefitid,
                                                                            client_clientid );

    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------

    -- TABLE 6: receiver
    CREATE TABLE receiver (
        receiverid      NUMBER(3) NOT NULL,
        client_clientid NUMBER(3) NOT NULL
    );
    ALTER TABLE receiver ADD CONSTRAINT receiver_pk PRIMARY KEY ( receiverid );

    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------

    -- TABLE 7: sender
    CREATE TABLE sender (
        senderid        NUMBER(3) NOT NULL,
        client_clientid NUMBER(3) NOT NULL
    );
    ALTER TABLE sender ADD CONSTRAINT sender_pk PRIMARY KEY ( senderid );

    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------

    -- TABLE 8: transaction
    CREATE TABLE transaction (
        transactionid         NUMBER(10) NOT NULL,
        tdate                 DATE NOT NULL,
        tamount               NUMBER(10, 2) NOT NULL,
        bankaccount_accountid NUMBER(3),
        card_cardid           NUMBER(4),
        receiver_receiverid   NUMBER(3) NOT NULL,
        sender_senderid       NUMBER(3) NOT NULL
    );
    ALTER TABLE transaction ADD CONSTRAINT transaction_pk PRIMARY KEY ( transactionid );

    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------

    -- Set constraints for FKs
    ALTER TABLE client_benefit
        ADD CONSTRAINT client_benefit_benefits_fk FOREIGN KEY ( benefits_benefitid )
            REFERENCES benefits ( benefitid );

    ALTER TABLE client_benefit
        ADD CONSTRAINT client_benefit_client_fk FOREIGN KEY ( client_clientid )
            REFERENCES client ( clientid );

    ALTER TABLE receiver
        ADD CONSTRAINT receiver_client_fk FOREIGN KEY ( client_clientid )
            REFERENCES client ( clientid );

    ALTER TABLE sender
        ADD CONSTRAINT sender_client_fk FOREIGN KEY ( client_clientid )
            REFERENCES client ( clientid );

    ALTER TABLE transaction
        ADD CONSTRAINT transaction_bankaccount_fk FOREIGN KEY ( bankaccount_accountid )
            REFERENCES bankaccount ( accountid );

    ALTER TABLE transaction
        ADD CONSTRAINT transaction_card_fk FOREIGN KEY ( card_cardid )
            REFERENCES card ( cardid );

    ALTER TABLE transaction
        ADD CONSTRAINT transaction_receiver_fk FOREIGN KEY ( receiver_receiverid )
            REFERENCES receiver ( receiverid );

    ALTER TABLE transaction
        ADD CONSTRAINT transaction_sender_fk FOREIGN KEY ( sender_senderid )
            REFERENCES sender ( senderid );

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Part 4. DML commands
-- Level 1:
    -- BANKACCOUNT
    INSERT INTO bankaccount VALUES(
        accountid_seq.NEXTVAL,
        846028391653
    );
    INSERT INTO bankaccount VALUES(
        accountid_seq.NEXTVAL,
        8143140672769
    );
    INSERT INTO bankaccount VALUES(
        accountid_seq.NEXTVAL,
        131000123382
    );
    INSERT INTO bankaccount VALUES(
        accountid_seq.NEXTVAL,
        69590623697
    );
    INSERT INTO bankaccount VALUES(
        accountid_seq.NEXTVAL,
        42982469602
    );
    COMMIT;
--------------------------------------------------------------------------------
    -- CARD
    INSERT INTO card VALUES(
        cardid_seq.NEXTVAL,
        5108753972964674
    );
    INSERT INTO card VALUES(
        cardid_seq.NEXTVAL,
        5048379813908861
    );
    INSERT INTO card VALUES(
        cardid_seq.NEXTVAL,
        5048378058331185
    );
    INSERT INTO card VALUES(
        cardid_seq.NEXTVAL,
        5048370049961345
    );
    INSERT INTO card VALUES(
        cardid_seq.NEXTVAL,
        5108759733860317
    );
    COMMIT;
--------------------------------------------------------------------------------
    -- CLIENT
    insert into CLIENT (clientID, clientLast, clientFirst, balance, phone, streetAddress, state, email) values (1, 'Sandiford', 'Godiva', 8628.75, '5612842503', '864 Riverside Hill', 'FL', NULL);
    insert into CLIENT (clientID, clientLast, clientFirst, balance, phone, streetAddress, state, email) values (2, 'Waren', 'Mario', 7019.38, '2038187732', '54082 Kings Alley', 'CT', 'mwaren1@theglobeandmail.com');
    insert into CLIENT (clientID, clientLast, clientFirst, balance, phone, streetAddress, state, email) values (3, 'Wandrey', 'Mattias', 4632.67, '8161798994', '0953 Granby Way', 'MO', 'mwandrey2@surveymonkey.com');
    insert into CLIENT (clientID, clientLast, clientFirst, balance, phone, streetAddress, state, email) values (4, 'Gatus', 'Robenia', 1947.63, '9079764177', '6177 New Castle Parkway', 'AK', 'rgatus3@indiegogo.com');
    insert into CLIENT (clientID, clientLast, clientFirst, balance, phone, streetAddress, state, email) values (5, 'Meineken', 'Galina', 5958.86, '8595175118', '950 Stephen Road', 'KY', 'gmeineken4@comsenz.com');
    COMMIT;
--------------------------------------------------------------------------------
    -- BENEFITS
    INSERT INTO BENEFITS VALUES (1, 'Instant Transfer');
    INSERT INTO BENEFITS VALUES (2, '0.5% Cashback');
    INSERT INTO BENEFITS VALUES (3, '1% Cashback');
    INSERT INTO BENEFITS VALUES (4, '2% Cashback');
    INSERT INTO BENEFITS VALUES (5, '3% Cashback');
    COMMIT;
    
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- Level 2:
    -- SENDER 
    INSERT INTO SENDER VALUES(1, 1);
    INSERT INTO SENDER VALUES(2, 2);
    INSERT INTO SENDER VALUES(3, 3);
    INSERT INTO SENDER VALUES(4, 4);
    INSERT INTO SENDER VALUES(5, 5);
    COMMIT;
--------------------------------------------------------------------------------
    -- RECEIVER
    INSERT INTO RECEIVER VALUES(1, 1);
    INSERT INTO RECEIVER VALUES(2, 2);
    INSERT INTO RECEIVER VALUES(3, 3);
    INSERT INTO RECEIVER VALUES(4, 4);
    INSERT INTO RECEIVER VALUES(5, 5);
    COMMIT;
--------------------------------------------------------------------------------
    -- CLIENT_BENEFIT
    INSERT INTO CLIENT_BENEFIT VALUES (TO_DATE('01/27/1998', 'MM/DD/YYYY'), 1, 3);
    INSERT INTO CLIENT_BENEFIT VALUES (TO_DATE('12/17/2021', 'MM/DD/YYYY'), 2, 3);
    INSERT INTO CLIENT_BENEFIT VALUES (TO_DATE('01/27/2022', 'MM/DD/YYYY'), 3, 1);
    INSERT INTO CLIENT_BENEFIT VALUES (TO_DATE('12/25/2023', 'MM/DD/YYYY'), 4, 2);
    INSERT INTO CLIENT_BENEFIT VALUES (TO_DATE('12/03/2023', 'MM/DD/YYYY'), 4, 5);
    COMMIT;
    
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- LEVEL 3:
    -- TRANSACTION
    INSERT INTO TRANSACTION VALUES (1, TO_DATE('2023-12-01', 'YYYY-MM-DD'), 550.00, 1, NULL, 2, 1);
    INSERT INTO TRANSACTION VALUES (2, TO_DATE('2023-12-02', 'YYYY-MM-DD'), 300.00, NULL, 1, 3, 1);
    INSERT INTO TRANSACTION VALUES (3, TO_DATE('2023-12-03', 'YYYY-MM-DD'), 750.00, NULL, 2, 3, 2);
    INSERT INTO TRANSACTION VALUES (4, TO_DATE('2023-12-04', 'YYYY-MM-DD'), 1000.00, 4, NULL, 1, 4);
    INSERT INTO TRANSACTION VALUES (5, TO_DATE('2023-12-05', 'YYYY-MM-DD'), 1200.00, 5, NULL, 2, 4);
    INSERT INTO TRANSACTION VALUES (6, TO_DATE('2023-12-06', 'YYYY-MM-DD'), 1400.00, 3, NULL, 2, 3);
    INSERT INTO TRANSACTION VALUES (7, TO_DATE('2023-12-07', 'YYYY-MM-DD'), 900.00, NULL, 4, 3, 4);
    COMMIT;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Part 5. Queries, PL/SQL and Index 

-- 1. inner join
-- Return clients' lastname and firstname
-- who have benefit(s) and have sent money before.

    -- Tranditional Join
    SELECT UNIQUE(clientid), clientlast, clientfirst
    FROM CLIENT c, client_benefit cb, SENDER s, TRANSACTION t
    WHERE c.clientid = cb.client_clientid
    AND c.clientid = s.client_clientid
    AND s.senderid = t.sender_senderid
    ORDER BY clientid;

    -- Join On
    SELECT UNIQUE(clientid), clientlast, clientfirst
    FROM client c
    JOIN client_benefit cb ON c.clientid = cb.client_clientid
    JOIN sender s ON c.clientid = s.client_clientid
    JOIN transaction t ON s.senderid = t.sender_senderid
    ORDER BY clientid;

------------------------------------------------------------------------
-- 2. outer join:
-- Return clients' lastname, firstname, and email
-- who have used transaction service as either sender or receiver

-- Reason for this outer join:
-- we can find clients who have used paymo to send survey through their email

    -- Traditional Join
    SELECT DISTINCT clientid, clientfirst, clientlast, email
    FROM client c, receiver r, transaction t
    WHERE r.client_clientid = c.clientid(+)
    AND r.receiverid = t.receiver_receiverid
    UNION
    SELECT DISTINCT clientid, clientfirst, clientlast, email
    FROM client c, sender s, transaction t
    WHERE s.client_clientid = c.clientid(+)
    AND s.senderid = t.sender_senderid
    ORDER BY clientid;

------------------------------------------------------------------------
-- 3. 
-- single row fuction: CASE

-- Return transactionid and the amount in the transaction classified with 4 types
-- to check a possibility of scam on each transaction
    SELECT transactionid AS t_id, tamount AS Amount,
    CASE
    WHEN (tamount < 100) THEN 'Very Low'
    WHEN (tamount < 500) THEN 'Low'
    WHEN (tamount < 1000) THEN 'Moderate'
    WHEN (tamount >= 1000) THEN 'High'
    END "Possibility of Scam"
    FROM transaction
    ORDER BY tamount;

-- group function: GROUP BY

-- Return senderid and the number of time each sender sent money in transaction
-- to figure out how many times each sender used transaction service
    SELECT COUNT(transaction.sender_senderid) AS "# of transactions", sender_senderid AS "sender id"
    FROM transaction
    GROUP BY sender_senderid
    ORDER BY "# of transactions";

------------------------------------------------------------------------
-- 4.
-- Create an index.

-- screenshots attached at the masterfile.
-- The index didn't improve the query response in this project. 

------------------------------------------------------------------------
-- 5.
-- Create a nested query that contains 2 subqueries and 1 main query

-- Return tamount and cardid that have done the largest transaction

-- main query
    SELECT tamount, cardid FROM transaction t, card c
    WHERE tamount = (
        SELECT MAX(tamount)
        FROM transaction t, card c
        WHERE t.card_cardid = c.cardid)
    AND cardid = (
        SELECT cardid
        FROM (
            SELECT cardid,
                RANK() OVER (ORDER BY t.tamount DESC) as rank
            FROM transaction t
            JOIN card c ON t.card_cardid = c.cardid
        )
        WHERE rank = 1
    );

-- subquery 1
    SELECT MAX(tamount) FROM transaction t, card c
    WHERE t.card_cardid = c.cardid;

    -- subquery 2
    SELECT cardid
    FROM (
        SELECT cardid,
            RANK() OVER (ORDER BY t.tamount DESC) as rank
        FROM transaction t
        JOIN card c ON t.card_cardid = c.cardid
    )
    WHERE rank = 1;

------------------------------------------------------------------------
-- 6.
-- Use PL/SQL to automate a task using a cursor

DECLARE
    cur_clientid client.clientid%TYPE;
    cur_email client.email%TYPE;
    a numeric := &a ; 
BEGIN
    SELECT clientid, email
    INTO cur_clientid, cur_email
    FROM client WHERE clientid = a;
    dbms_output.put_line(cur_email);
END;
/

-- We tried to get client's email by entering clientid,
-- but it doesn't display anything even though it compiled successfully



