-- Create a database for NFL app
use master;
 -- CREATE DATABASE MIST_RDB_Cooper;
 -- DROP database NFL_RDB_Cooper;
  use MIST_RDB_Cooper;
 -- Create tables for first iteration

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

 

