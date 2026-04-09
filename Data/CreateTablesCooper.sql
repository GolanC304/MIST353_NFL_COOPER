
-- USE master;
-- CREATE DATABASE MIST_RDB_Cooper;
GO
--test
-- ===================================
-- Drop tables if they exist

IF OBJECT_ID('Team', 'U') IS NOT NULL DROP TABLE Team;
IF OBJECT_ID('ConferenceDivision', 'U') IS NOT NULL DROP TABLE ConferenceDivision;
GO

-- Create tables
CREATE TABLE ConferenceDivision (
    ConferenceDivisionID INT IDENTITY(1,1) PRIMARY KEY,
    Conference NVARCHAR(50) NOT NULL
        CONSTRAINT CK_ConferenceNames CHECK (Conference IN ('AFC','NFC')),
    Division NVARCHAR(50) NOT NULL
        CONSTRAINT CK_DivisionNames CHECK (Division IN ('East','North','South','West'))
);
GO

CREATE TABLE Team (
    TeamID INT IDENTITY(1,1) PRIMARY KEY,
    TeamName NVARCHAR(50) NOT NULL,
    TeamCityState NVARCHAR(50) NOT NULL,
    TeamColors NVARCHAR(50) NOT NULL,
    ConferenceDivisionID INT NOT NULL
        CONSTRAINT FK_Team_ConferenceDivision 
        FOREIGN KEY REFERENCES ConferenceDivision(ConferenceDivisionID)
);
GO

 --teams by conference/division
CREATE OR ALTER PROCEDURE procGetTeamsByConferenceDivision
(
    @ConferenceName NVARCHAR(50) = NULL,
    @DivisionName NVARCHAR(50) = NULL
)
AS
BEGIN
    SELECT T.TeamName, T.TeamColors, CD.Conference, CD.Division
    FROM Team T
    JOIN ConferenceDivision CD
        ON T.ConferenceDivisionID = CD.ConferenceDivisionID
    WHERE (@ConferenceName IS NULL OR CD.Conference = @ConferenceName)
      AND (@DivisionName IS NULL OR CD.Division = @DivisionName);
END
GO
Create table AppUser(
        AppUserID INT identity(1,1)
            constraint PK_AppUser PRIMARY KEY,
        Firstname NVARCHAR(50) NOT NULL,
        Lastname NVARCHAR(50) NOT NULL,
        Email NVARCHAR(100) NOT NULL
            constraint UK_AppUSerEmail UNIQUE,
        PasswordHash VARBINARY(200) NOT NULL,
        Phone NVARCHAR(20) NULL,
        UserRole NVARCHAR(20) NOT NULL
            constraint CK_AppUserRole CHECK (UserRole in (N'NFLAdmin',N'NFLFAN'))
);
GO
create table NFLAdmin(
    NFLAdminID INT
        constraint PK_NFLAdmin PRIMARY KEY
        constraint FK_NFLAdmin_AppUser FOREIGN KEY REFERENCES AppUser(AppUserID)
);


GO
create table NFLFAN(
    NFLFanID INT   
        Constraint PK_NFLFAN PRIMARY KEY
        constraint FK_NFL_Fan_AppUser FOREIGN KEY REFERENCES AppUser(AppUserID)
);

GO
create table FanTeam(
    FanTeamID INT identity(1,1)
        constraint PK_FanTeam PRIMARY KEY,
    NFLFanID INT NOT NULL
        constraint FK_FanTeam_NFLFan FOREIGN KEY REFERENCES NFLFAN(NFLFANID),
    TeamID INT NOT NULL 
        constraint FK_FanTeam_Team FOREIGN KEY REFERENCES Team(TeamID),
        constraint UK_FanTeam UNIQUE (NFLFanID, TeamID),
    PrimaryTeam BIT NOT NULL




)



GO



-- conference/division as a specific team

CREATE OR ALTER PROCEDURE procGetTeamsInSameConferenceDivisionAsSpecifiedTeam
(
    @TeamName NVARCHAR(50)
)
AS
BEGIN
    SELECT OT.TeamName, CD.Conference, CD.Division
    FROM Team T
    JOIN ConferenceDivision CD
        ON T.ConferenceDivisionID = CD.ConferenceDivisionID
    JOIN Team OT
        ON OT.ConferenceDivisionID = T.ConferenceDivisionID
    WHERE T.TeamName = @TeamName
      AND OT.TeamName <> @TeamName;  
END
GO