--Hayden Mankin
--Andrew Meade

--DROP VIEWS

DROP MATERIALIZED VIEW total_fines;

--DROP TABLES

DROP TABLE author CASCADE CONSTRAINTS;

DROP TABLE book CASCADE CONSTRAINTS;

DROP TABLE borrow CASCADE CONSTRAINTS;

DROP TABLE copyofbook CASCADE CONSTRAINTS;

DROP TABLE fine CASCADE CONSTRAINTS;

DROP TABLE genre CASCADE CONSTRAINTS;

DROP TABLE location CASCADE CONSTRAINTS;

DROP TABLE member CASCADE CONSTRAINTS;

DROP TABLE publisher CASCADE CONSTRAINTS;

DROP TABLE request CASCADE CONSTRAINTS;

DROP TABLE transfer CASCADE CONSTRAINTS;

--DROP SEQUENCES

DROP SEQUENCE publisher_publisherID_seq;
DROP SEQUENCE author_authorID_seq;
DROP SEQUENCE genre_genreID_seq;
DROP SEQUENCE member_memberID_seq;
DROP SEQUENCE location_locationID_seq;
DROP SEQUENCE fine_fineID_seq;
DROP SEQUENCE request_requestID_seq;
DROP SEQUENCE copyOfBook_bookID_seq;
DROP SEQUENCE borrow_borrowID_seq;
DROP SEQUENCE transfer_transferID_seq;

--CREATE TABLES

CREATE TABLE author (
    authorid       NUMBER(5) NOT NULL,
    authorfirst    VARCHAR2(30 CHAR) NOT NULL,
    authormiddle   VARCHAR2(30 CHAR),
    authorlast     VARCHAR2(30 CHAR) NOT NULL
);

ALTER TABLE author ADD CONSTRAINT author_pk PRIMARY KEY ( authorid );

CREATE TABLE book (
    isbn                    NUMBER(13) NOT NULL,
    publisherid   NUMBER(5) NOT NULL,
    authorid         NUMBER(5) NOT NULL,
    genreid           NUMBER(5) NOT NULL,
    title           VARCHAR2(30 CHAR) NOT NULL
);

ALTER TABLE book ADD CONSTRAINT book_pk PRIMARY KEY ( isbn );

CREATE TABLE borrow (
    borrowid              NUMBER(5) NOT NULL,
    memberid       NUMBER(5) NOT NULL,
    bookid     NUMBER(5) NOT NULL,
    borrowdate            DATE NOT NULL,
    duedate               DATE NOT NULL,
    returndate            DATE,
    locationid   NUMBER(5) NOT NULL,
    returndamages varchar2(200 CHAR)
);

ALTER TABLE borrow ADD CONSTRAINT borrow_pk PRIMARY KEY ( borrowid );

CREATE TABLE copyofbook (
    locationid   NUMBER(5) NOT NULL,
    bookid                NUMBER(5) NOT NULL,
    isbn             NUMBER(13) NOT NULL
);

ALTER TABLE copyofbook ADD CONSTRAINT copyofbook_pk PRIMARY KEY ( bookid );

CREATE TABLE fine (
    memberid   NUMBER(5) NOT NULL,
    fineid            NUMBER(5) NOT NULL,
    amount            NUMBER(6, 2) NOT NULL,
    datepaid          DATE
);

ALTER TABLE fine ADD CONSTRAINT fine_pk PRIMARY KEY ( fineid );

CREATE TABLE genre (
    genreid     NUMBER(5) NOT NULL,
    genrename   VARCHAR2(20 CHAR) NOT NULL
);

ALTER TABLE genre ADD CONSTRAINT genre_pk PRIMARY KEY ( genreid );

CREATE TABLE location (
    locationid       NUMBER(5) NOT NULL,
    locationstreet   VARCHAR2(30 CHAR) NOT NULL,
    locationcity     VARCHAR2(30 CHAR) NOT NULL,
    locationstate    CHAR(2 CHAR) NOT NULL,
    locationzip      NUMBER(5) NOT NULL,
    locationname    VARCHAR2(30) NOT NULL
);

ALTER TABLE location ADD CONSTRAINT location_pk PRIMARY KEY ( locationid );

CREATE TABLE member (
    memberid          NUMBER(5) NOT NULL,
    sponsorid   NUMBER(5),
    memberstreet      VARCHAR2(30 CHAR),
    membercity        VARCHAR2(30 CHAR),
    memberstate       CHAR(2 CHAR),
    memberzip         NUMBER(5),
    memberfirst       VARCHAR2(30 CHAR) NOT NULL,
    memberlast       VARCHAR2(30 CHAR) NOT NULL
);

ALTER TABLE member ADD CONSTRAINT member_pk PRIMARY KEY ( memberid );

CREATE TABLE publisher (
    publisherid     NUMBER(5) NOT NULL,
    publishername   VARCHAR2(30 CHAR) NOT NULL
);

ALTER TABLE publisher ADD CONSTRAINT publisher_pk PRIMARY KEY ( publisherid );

CREATE TABLE request (
    requestid             NUMBER(5) NOT NULL,
    memberid       NUMBER(5) NOT NULL,
    locationid   NUMBER(5) NOT NULL,
    isbn             NUMBER(13) NOT NULL,
    requestdate           DATE NOT NULL
);

ALTER TABLE request ADD CONSTRAINT request_pk PRIMARY KEY ( requestid );

CREATE TABLE transfer (
    locationid   NUMBER(5) NOT NULL,
    transferid            NUMBER(5) NOT NULL,
    bookid     NUMBER(5) NOT NULL,
    transfercompleted     DATE
);

ALTER TABLE transfer ADD CONSTRAINT transfer_pk PRIMARY KEY ( transferid );

ALTER TABLE book
    ADD CONSTRAINT book_author_fk FOREIGN KEY ( authorid )
        REFERENCES author ( authorid );

ALTER TABLE book
    ADD CONSTRAINT book_genre_fk FOREIGN KEY ( genreid )
        REFERENCES genre ( genreid );

ALTER TABLE book
    ADD CONSTRAINT book_publisher_fk FOREIGN KEY ( publisherid )
        REFERENCES publisher ( publisherid );

ALTER TABLE borrow
    ADD CONSTRAINT borrow_copyofbook_fk FOREIGN KEY ( bookid )
        REFERENCES copyofbook ( bookid );

ALTER TABLE borrow
    ADD CONSTRAINT borrow_location_fk FOREIGN KEY ( locationid )
        REFERENCES location ( locationid );

ALTER TABLE borrow
    ADD CONSTRAINT borrow_member_fk FOREIGN KEY ( memberid )
        REFERENCES member ( memberid );

ALTER TABLE copyofbook
    ADD CONSTRAINT copyofbook_book_fk FOREIGN KEY ( isbn )
        REFERENCES book ( isbn );

ALTER TABLE copyofbook
    ADD CONSTRAINT copyofbook_location_fk FOREIGN KEY ( locationid )
        REFERENCES location ( locationid );

ALTER TABLE fine
    ADD CONSTRAINT fine_member_fk FOREIGN KEY ( memberid )
        REFERENCES member ( memberid );

ALTER TABLE member
    ADD CONSTRAINT member_member_fk FOREIGN KEY ( sponsorid )
        REFERENCES member ( memberid );

ALTER TABLE request
    ADD CONSTRAINT request_book_fk FOREIGN KEY ( isbn )
        REFERENCES book ( isbn );

ALTER TABLE request
    ADD CONSTRAINT request_location_fk FOREIGN KEY ( locationid )
        REFERENCES location ( locationid );

ALTER TABLE request
    ADD CONSTRAINT request_member_fk FOREIGN KEY ( memberid )
        REFERENCES member ( memberid );

ALTER TABLE transfer
    ADD CONSTRAINT transfer_copyofbook_fk FOREIGN KEY ( bookid )
        REFERENCES copyofbook ( bookid );

ALTER TABLE transfer
    ADD CONSTRAINT transfer_location_fk FOREIGN KEY ( locationid )
        REFERENCES location ( locationid );
        
--Inserts

--Level 1

--Publisher

CREATE SEQUENCE publisher_publisherID_seq 
START WITH 1
INCREMENT BY 1
NOCACHE;

DESC publisher;

INSERT INTO publisher VALUES (
publisher_publisherID_seq.nextval,
'Hachette'
);

INSERT INTO publisher VALUES (
publisher_publisherID_seq.nextval,
'HarperCollins'
);

INSERT INTO publisher VALUES (
publisher_publisherID_seq.nextval,
'Macmillan'
);

INSERT INTO publisher VALUES (
publisher_publisherID_seq.nextval,
'Penguin Random House'
);

INSERT INTO publisher VALUES (
publisher_publisherID_seq.nextval,
'Simon And Schuster'
);

--Author

CREATE SEQUENCE author_authorID_seq 
START WITH 1
INCREMENT BY 1
NOCACHE;

DESC author;

INSERT INTO author VALUES (
author_authorID_seq.nextval,
'A',
'Z',
'Tremlett'
);

INSERT INTO author VALUES (
author_authorID_seq.nextval,
'Alice',
'Z',
'Tidy'
);

INSERT INTO author VALUES (
author_authorID_seq.nextval,
'Trescothik',
'',
'Ablood'
);

INSERT INTO author VALUES (
author_authorID_seq.nextval,
'Sootie',
'',
'Jones'
);

INSERT INTO author VALUES (
author_authorID_seq.nextval,
'Zehavit',
'Aie',
'Truss'
);

--Genre

CREATE SEQUENCE genre_genreID_seq 
START WITH 1
INCREMENT BY 1
NOCACHE;

DESC genre;

INSERT INTO genre VALUES (
genre_genreID_seq.nextval,
'romance'
);

INSERT INTO genre VALUES (
genre_genreID_seq.nextval,
'science fiction'
);

INSERT INTO genre VALUES (
genre_genreID_seq.nextval,
'fantasy'
);

INSERT INTO genre VALUES (
genre_genreID_seq.nextval,
'crime'
);

INSERT INTO genre VALUES (
genre_genreID_seq.nextval,
'non fiction'
);

--Member

CREATE SEQUENCE member_memberID_seq 
START WITH 1
INCREMENT BY 1
NOCACHE;

DESC member;

INSERT INTO member VALUES (
member_memberID_seq.nextval,
NULL,
'3853 Crummit Lane',
'Lincoln',
'NE',
68501,
'Charles',
'McKean'
);

INSERT INTO member VALUES (
member_memberID_seq.nextval,
NULL,
'2628 Terra Street',
'Everett',
'WA',
98201,
'Hugh',
'Russo'
);

INSERT INTO member VALUES (
member_memberID_seq.nextval,
2,
NULL,
NULL,
NULL,
NULL,
'Thaddeus',
'Wheat'
);

INSERT INTO member VALUES (
member_memberID_seq.nextval,
2,
NULL,
NULL,
NULL,
NULL,
'Caitlin',
'Borchardt'
);

INSERT INTO member VALUES (
member_memberID_seq.nextval,
NULL,
'2407 Pinnick Street',
'Alger',
'WA',
98233,
'Marylin',
'Mance'
);

--Location

CREATE SEQUENCE location_locationID_seq 
START WITH 1
INCREMENT BY 1
NOCACHE;

DESC location;

INSERT INTO location VALUES (
location_locationID_seq.nextval,
'4857 Duke Lane',
'Keyport',
'NJ',
07735,
'Keyport Branch'
);

INSERT INTO location VALUES (
location_locationID_seq.nextval,
'2805 Golden Road',
'Albany',
'NY',
12210,
'New Beginning'
);

INSERT INTO location VALUES (
location_locationID_seq.nextval,
'1861 Briarhill Lane',
'Akron',
'OH',
44303,
'Amenity'
);

INSERT INTO location VALUES (
location_locationID_seq.nextval,
'3412 Big Elm',
'Strasburg',
'MO',
64090,
'Grotto'
);

INSERT INTO location VALUES (
location_locationID_seq.nextval,
'130 Glendwood Avenue',
'Cleveland',
'OH',
44111,
'Reticence'
);

--Level 2

--Book

DESC Book;

INSERT INTO book VALUES (
9781123456121,
1,
5,
1,
'Parrot Of The Day'
);

INSERT INTO book VALUES (
9781123456122,
2,
4,
5,
'Emperor Of Earth'
);

INSERT INTO book VALUES (
9781123456123,
3,
3,
2,
'Walking The Angels'
);

INSERT INTO book VALUES (
9781123456124,
4,
2,
4,
'Humans Of The Curse'
);

INSERT INTO book VALUES (
9781123456125,
5,
1,
3,
'Butchers Of Nightmares'
);

--Fine

CREATE SEQUENCE fine_fineID_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

DESC fine;

INSERT INTO fine VALUES (
1,
fine_fineID_seq.nextval,
10.00,
TO_DATE('01/01/2018','MM/DD/YYYY')
);

INSERT INTO fine VALUES (
1,
fine_fineID_seq.nextval,
10.00,
NULL
);

INSERT INTO fine VALUES (
2,
fine_fineID_seq.nextval,
20.00,
NULL
);

INSERT INTO fine VALUES (
3,
fine_fineID_seq.nextval,
5.25,
NULL
);

INSERT INTO fine VALUES (
4,
fine_fineID_seq.nextval,
1.50,
NULL
);

--Level 3

--Request

CREATE SEQUENCE request_requestID_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

DESC request;

INSERT INTO request VALUES (
request_requestID_seq.nextval,
1,
1,
9781123456121,
TO_DATE('01/01/2000','MM/DD/YYYY')
);

INSERT INTO request VALUES (
request_requestID_seq.nextval,
1,
1,
9781123456122,
TO_DATE('01/01/2000','MM/DD/YYYY')
);

INSERT INTO request VALUES (
request_requestID_seq.nextval,
2,
3,
9781123456123,
TO_DATE('01/01/2000','MM/DD/YYYY')
);

INSERT INTO request VALUES (
request_requestID_seq.nextval,
2,
3,
9781123456124,
TO_DATE('01/01/2000','MM/DD/YYYY')
);

INSERT INTO request VALUES (
request_requestID_seq.nextval,
3,
5,
9781123456125,
TO_DATE('01/01/2000','MM/DD/YYYY')
);

--CopyOfBook

CREATE SEQUENCE copyOfBook_bookID_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

DESC CopyOfBook;

INSERT INTO copyOfBook VALUES (
2,
copyOfBook_bookID_seq.nextval,
9781123456121
);

INSERT INTO copyOfBook VALUES (
2,
copyOfBook_bookID_seq.nextval,
9781123456122
);

INSERT INTO copyOfBook VALUES (
2,
copyOfBook_bookID_seq.nextval,
9781123456123
);

INSERT INTO copyOfBook VALUES (
4,
copyOfBook_bookID_seq.nextval,
9781123456124
);

INSERT INTO copyOfBook VALUES (
4,
copyOfBook_bookID_seq.nextval,
9781123456125
);

INSERT INTO copyOfBook VALUES (
4,
copyOfBook_bookID_seq.nextval,
9781123456125
);

--Level 4

--Borrow

CREATE SEQUENCE borrow_borrowID_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

DESC borrow;

INSERT INTO borrow VALUES (
borrow_borrowID_seq.nextval,
1,
5,
TO_DATE('01/01/2018','MM/DD/YYYY'),
TO_DATE('06/01/2018','MM/DD/YYYY'),
TO_DATE('03/01/2018','MM/DD/YYYY'),
4,
'water damage on cover'
);

INSERT INTO borrow VALUES (
borrow_borrowID_seq.nextval,
2,
4,
TO_DATE('01/01/2018','MM/DD/YYYY'),
TO_DATE('06/01/2018','MM/DD/YYYY'),
TO_DATE('03/01/2018','MM/DD/YYYY'),
4,
NULL
);

INSERT INTO borrow VALUES (
borrow_borrowID_seq.nextval,
3,
3,
TO_DATE('01/01/2018','MM/DD/YYYY'),
TO_DATE('06/01/2018','MM/DD/YYYY'),
TO_DATE('03/01/2018','MM/DD/YYYY'),
2,
'visible burn marks on inside cover'
);

INSERT INTO borrow VALUES (
borrow_borrowID_seq.nextval,
4,
2,
TO_DATE('06/01/2019','MM/DD/YYYY'),
TO_DATE('12/01/2019','MM/DD/YYYY'),
NULL,
2,
NULL
);

INSERT INTO borrow VALUES (
borrow_borrowID_seq.nextval,
5,
1,
TO_DATE('06/01/2019','MM/DD/YYYY'),
TO_DATE('12/01/2019','MM/DD/YYYY'),
NULL,
2,
NULL
);

--Transfer

CREATE SEQUENCE transfer_transferID_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

DESC transfer;

INSERT INTO transfer VALUES (
2,
transfer_transferID_seq.nextval,
1,
TO_DATE('01/01/2017','MM/DD/YYYY')
);

INSERT INTO transfer VALUES (
2,
transfer_transferID_seq.nextval,
1,
TO_DATE('01/01/2017','MM/DD/YYYY')
);

INSERT INTO transfer VALUES (
2,
transfer_transferID_seq.nextval,
1,
TO_DATE('01/01/2017','MM/DD/YYYY')
);

INSERT INTO transfer VALUES (
4,
transfer_transferID_seq.nextval,
1,
TO_DATE('01/01/2017','MM/DD/YYYY')
);

INSERT INTO transfer VALUES (
4,
transfer_transferID_seq.nextval,
1,
TO_DATE('01/01/2017','MM/DD/YYYY')
);

--Queries

--1
--return list of damages previously noted, and member responsible (3 Table Inner Join)
SELECT bookid,returndamages,memberfirst,memberlast,returndate FROM member NATURAL JOIN borrow NATURAL JOIN copyOfBook WHERE returndate IS NOT NULL AND bookid=5;

--2
--find sponsor address for dependent members (Self Join)
SELECT a.memberfirst as "first", a.memberlast as "last", b.memberfirst as "sponsor first", b.memberlast as "sponsor last", b.memberstreet, b.membercity, b.memberstate, b.memberzip FROM member a, member b WHERE a.sponsorid=b.memberid;

--3
--Create Materialized View
--List total fines owed by each customer
CREATE MATERIALIZED VIEW total_fines
REFRESH COMPLETE
START WITH SYSDATE NEXT SYSDATE+7
AS SELECT memberid,memberfirst,memberlast,SUM(amount) as totalFines 
FROM member NATURAL JOIN fine 
WHERE datepaid IS NULL 
GROUP BY memberid,memberfirst,memberlast;

--4
--Stats about yearly books checked out: Max books checked out in a year, min books checked out in a year, standard deviation year to year.
--a statistical function, 2 group functions and a single row function that requires 2 tables
SELECT MAX(COUNT(*)),MIN(COUNT(*)), ROUND(STDDEV(COUNT(*))) FROM borrow NATURAL JOIN member GROUP BY TO_CHAR(borrowdate,'YYYY');


--5
--All requests that have a book avaliable somewhere in the system, info includes the book, where it is now, and where it is requested to be at.
--Create a nested subquery that contains 2 subqueries and 1 main query
SELECT r.requestID,r.memberID,r.locationID as "Requested Locaiton",c.isbn as "Requested Book",c.bookid,c.locationID as "Current location" FROM request r JOIN copyOfBook c ON r.isbn=c.isbn WHERE c.bookid IN (
SELECT bookid FROM copyOfBook
MINUS
SELECT c.bookid FROM copyOfBook c LEFT OUTER JOIN borrow b on c.bookid=b.bookid WHERE (returndate IS NULL AND borrowdate IS NOT NULL) AND isbn IN (
SELECT isbn FROM request));

--6
--create a balanced tree on author last name, as searching by author name will be very common
--cost of 3 before, cost of 2 after
CREATE INDEX author_authorLast_idx ON author(authorLast);
select authorid FROM author WHERE authorlast='Tidy';

--7
DECLARE
CURSOR fine_cursor IS
    SELECT memberlast, amount 
    FROM fine NATURAL JOIN member
    WHERE datepaid IS NULL;
fine_row fine_cursor%ROWTYPE;
total_due NUMBER(12);
BEGIN
total_due := 0;
    FOR fine_row IN fine_cursor
LOOP
    DBMS_OUTPUT.PUT_LINE(fine_row.memberlast ||  ' owes ' || TO_CHAR(fine_row.amount, 'fm$999,999,999'));
total_due := total_due + fine_row.amount;
END LOOP;
DBMS_OUTPUT.PUT_LINE('Total Due: ' || TO_CHAR(total_due, '$999,999,999'));
END;