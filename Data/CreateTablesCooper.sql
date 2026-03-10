-- Create a database for NFL app
 --use master
  --create DATABASE MIST_RDB_Cooper;
 -- DROP database NFL_RDB_Cooper;
-- use MIST_RDB_Cooper;
 -- Create tables for first iteration


-- Step 1: Create a login at the server level
/*
CREATE LOGIN NandaSurendra
WITH PASSWORD = 'MI$T353Instructor';
-- Step 2: Switch to your target database
-- USE MIST353_NFL_RDB_Lastname;
-- Step 3: Create a database user mapped to the login
CREATE USER NandaSurendra
FOR LOGIN NandaSurendra;
-- Step 4: Grant EXECUTE permission on all stored procedures and UDFs
GRANT EXECUTE TO NandaSurendra;
-- Read access to all tables
GRANT SELECT TO NandaSurendra;
*/

 -- =========== API Login =============
-- Step 1: Create a login at the server level
/*

CREATE LOGIN APILogin -- NAnda
WITH PASSWORD = 'MI$T353Instructor';
-- Step 2: Switch to your target database
-- Step 3: Create a database user mapped to the login
*/
--CREATE USER APIUser;

--FOR LOGIN APILogin;
-- Step 4: Grant EXECUTE permission on all stored procedures and UDFs
--GRANT EXECUTE TO APIUser;
-- Read access to all tables
--GRANT SELECT TO APIUser;

 -- ===================================
 
-- Database
if (OBJECT_ID('Team') is not null)
    drop table Team;

 if (OBJECT_ID('ConferenceDivision') is not null)
    drop table ConferenceDivision;


 create TABLE ConferenceDivision(
    ConferenceDivisionID INT identity(1,1)
        constraint PK_ConferenceDivision PRIMARY KEY,
    Conference NVARCHAR(50) NOT NULL
        constraint CK_ConferenceNames CHECK (Conference IN ('AFC', 'NFC')),
    Division NVARCHAR(50) NOT NULL
        constraint CK_DivisonNames CHECK (Division IN ('East', 'North', 'South', 'West'))
 );
 
create TABLE Team(
    TeamID INT identity(1,1)  -- starts at 1 and goes up by 1 each time
        constraint PK_Team PRIMARY KEY, -- specific rule for that variable
    TeamName NVARCHAR(50) NOT NULL,
    TeamCityState NVARCHAR(50) NOT NULL,
    TeamColors NVARCHAR(50) NOT NULL,
    ConferenceDivisionID INT NOT NULL
        constraint FK_Team_ConferenceDivision FOREIGN KEY REFERENCES ConferenceDivision(ConferenceDivisionID)
 );


 -- No reason to run this unless its millions of code
-- alter table ConferenceDivision
   -- NOCHECK CONSTRAINT CK_ConferenceNames;

 --alter table ConferenceDivision
   -- Check COnstraint CK_ConferenceNames;

 

