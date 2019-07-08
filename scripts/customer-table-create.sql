USE sampledb;

DROP TABLE IF EXISTS customer;

CREATE TABLE IF NOT EXISTS customer 
(
    id            INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
    customerName  VARCHAR( 255 ) NOT NULL, 
    effectiveDate DATE, 
    description   TEXT, 
    status        TINYINT NOT NULL
    );