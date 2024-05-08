DROP SCHEMA FLIGHT_IMPL CASCADE;
CREATE SCHEMA FLIGHT_IMPL;

DROP SCHEMA FLIGHT_API CASCADE;
CREATE SCHEMA FLIGHT_API;

DROP USER FLIGHT_API_USER;
CREATE USER FLIGHT_API_USER PASSWORD <password> NO FORCE_FIRST_PASSWORD_CHANGE;

GRANT SELECT ON SCHEMA FLIGHT_API TO FLIGHT_API_USER;
GRANT INSERT, UPDATE, DELETE ON SCHEMA FLIGHT_API TO FLIGHT_API_USER;

SET SCHEMA FLIGHT_IMPL;

CREATE TABLE AGENCY(
    AGENCY_ID NVARCHAR(6) NOT NULL,
    NAME NVARCHAR(80),
    STREET NVARCHAR(60),
    POSTAL_CODE NVARCHAR(10),
    CITY NVARCHAR(40),
    COUNTRY_CODE NVARCHAR(3),
    PHONE_NUMBER NVARCHAR(30),
    EMAIL_ADDRESS NVARCHAR(256),
    WEB_ADDRESS NVARCHAR(256),
    PRIMARY KEY(
        AGENCY_ID
    )
);

CREATE TABLE TRAVEL(
    TRAVEL_ID NVARCHAR(8) NOT NULL,
    AGENCY_ID NVARCHAR(6),
    CUSTOMER_ID NVARCHAR(6),
    BEGIN_DATE DATE,
    END_DATE DATE,
    BOOKING_FEE DECIMAL,
    TOTAL_PRICE DECIMAL,
    CURRENCY_CODE NVARCHAR(5),
    DESCRIPTION NVARCHAR(1024),
    STATUS NVARCHAR(1),
    PRIMARY KEY(
        TRAVEL_ID
    )
);

CREATE TABLE CUSTOMER(
    CUSTOMER_ID NVARCHAR(6) NOT NULL,
    FIRST_NAME NVARCHAR(40),
    LAST_NAME NVARCHAR(40),
    TITLE NVARCHAR(10),
    STREET NVARCHAR(60),
    POSTAL_CODE NVARCHAR(10),
    CITY NVARCHAR(40),
    COUNTRY_CODE NVARCHAR(3),
    PHONE_NUMBER NVARCHAR(30),
    EMAIL_ADDRESS NVARCHAR(256),
    PRIMARY KEY(
        CUSTOMER_ID
    )
);

CREATE TABLE BOOKING(
    TRAVEL_ID NVARCHAR(8) NOT NULL,
    BOOKING_ID NVARCHAR(4) NOT NULL,
    BOOKING_DATE DATE,
    CUSTOMER_ID NVARCHAR(6),
    CARRIER_ID NVARCHAR(3),
    CONNECTION_ID NVARCHAR(4),
    FLIGHT_DATE DATE,
    FLIGHT_PRICE DECIMAL,
    CURRENCY_CODE NVARCHAR(5),
    PRIMARY KEY(
        TRAVEL_ID,
        BOOKING_ID
    )
);

CREATE TABLE FLIGHT(
    CARRIER_ID NVARCHAR(3) NOT NULL,
    CONNECTION_ID NVARCHAR(4) NOT NULL,
    FLIGHT_DATE DATE NOT NULL,
    PRICE DECIMAL,
    CURRENCY_CODE NVARCHAR(5),
    PLANE_TYPE NVARCHAR(10),
    MAXIMUM_SEATS INTEGER,
    OCCUPIED_SEATS INTEGER,
    PRIMARY KEY(
        CARRIER_ID,
        CONNECTION_ID,
        FLIGHT_DATE
    )
);

CREATE TABLE CONNECTION(
    CARRIER_ID NVARCHAR(3) NOT NULL,
    CONNECTION_ID NVARCHAR(4) NOT NULL,
    DEPARTURE_AIRPORT_ID NVARCHAR(3),
    DESTINATION_AIRPORT_ID NVARCHAR(3),
    DEPARTURE_TIME TIME,
    ARRIVAL_TIME TIME,
    DISTANCE INTEGER,
    DISTANCE_UNIT NVARCHAR(3),
    PRIMARY KEY(
        CARRIER_ID,
        CONNECTION_ID
    )
);

CREATE TABLE AIRPORT(
    AIRPORT_ID NVARCHAR(3) NOT NULL,
    NAME NVARCHAR(40),
    CITY NVARCHAR(40),
    COUNTRY_CODE NVARCHAR(3),
    PRIMARY KEY(
        AIRPORT_ID
    )
);

CREATE TABLE CARRIER(
    CARRIER_ID NVARCHAR(3) NOT NULL,
    NAME NVARCHAR(40),
    CURRENCY_CODE NVARCHAR(5),
    PRIMARY KEY(
        CARRIER_ID
    )
);

SET SCHEMA FLIGHT_API;

CREATE VIEW AGENCY AS SELECT * FROM FLIGHT_IMPL.AGENCY;

CREATE VIEW TRAVEL AS SELECT * FROM FLIGHT_IMPL.TRAVEL;

CREATE VIEW CUSTOMER AS SELECT * FROM FLIGHT_IMPL.CUSTOMER;

CREATE VIEW BOOKING AS SELECT * FROM FLIGHT_IMPL.BOOKING;

CREATE VIEW FLIGHT AS SELECT * FROM FLIGHT_IMPL.FLIGHT;

CREATE VIEW CONNECTION AS SELECT * FROM FLIGHT_IMPL.CONNECTION;

CREATE VIEW AIRPORT AS SELECT * FROM FLIGHT_IMPL.AIRPORT;

CREATE VIEW CARRIER AS SELECT * FROM FLIGHT_IMPL.CARRIER;
