
-- Procedure: Add a New Team

CREATE OR ALTER PROCEDURE MIST353NFLCooper_AddTeam
(
    @TName NVARCHAR(50),
    @TCityState NVARCHAR(50),
    @TColors NVARCHAR(50),
    @ConferenceDivID INT
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
    VALUES (@TName, @TCityState, @TColors, @ConferenceDivID);
END
GO

-- Procedure: Get Teams by Division Only
CREATE OR ALTER PROCEDURE usp_GetTeamsByDivision
(
    @Division NVARCHAR(50)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        T.TeamID,
        T.TeamName,
        T.TeamCityState,
        T.TeamColors,
        CD.Conference,
        CD.Division
    FROM Team T
    INNER JOIN ConferenceDivision CD
        ON T.ConferenceDivisionID = CD.ConferenceDivisionID
    WHERE CD.Division = @Division
    ORDER BY T.TeamName;
END
GO


--Get Teams by Conference Only
CREATE OR ALTER PROCEDURE GetTeamsByConference
(
    @conference NVARCHAR(50)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DISTINCT
        T.TeamName,
        CD.Division
    FROM Team T
    INNER JOIN ConferenceDivision CD
        ON T.ConferenceDivisionID = CD.ConferenceDivisionID
    WHERE CD.Conference = @conference
    ORDER BY CD.Division, T.TeamName;
END
GO


SELECT * FROM Team T
JOIN ConferenceDivision CD
    ON T.ConferenceDivisionID = CD.ConferenceDivisionID
WHERE CD.Conference = 'NFC' AND CD.Division = 'West';

SELECT * FROM ConferenceDivision;

SELECT T.TeamName, CD.Conference, CD.Division
FROM Team T
JOIN ConferenceDivision CD
    ON T.ConferenceDivisionID = CD.ConferenceDivisionID;