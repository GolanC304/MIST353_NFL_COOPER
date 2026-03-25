
/*CREATE PROCEDURE MIST353NFLCooper_AddTeam
    @TName NVARCHAR(50),
    @TCityState NVARCHAR(50),
    @TColors NVARCHAR(50),
    @ConferenceDivID INT
AS
BEGIN
    INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
    VALUES (@TName, @TCityState, @TColors, @ConferenceDivID);
END;
GO   



CREATE PROCEDURE usp_GetTeamsByDivision
    @Division NVARCHAR(50)
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
END;
GO

*/

/* DECLARE @myTeamName NVARCHAR(50) = 'New England Patriots';

SELECT OtherTeam.TeamName
FROM Team AS MyTeam
INNER JOIN Team AS OtherTeam 
    ON MyTeam.ConferenceDivisionID = OtherTeam.ConferenceDivisionID
WHERE MyTeam.TeamName = @myTeamName 
  AND OtherTeam.TeamName != @myTeamName;
GO
*/
SELECT * FROM Team T
JOIN ConferenceDivision CD
    ON T.ConferenceDivisionID = CD.ConferenceDivisionID
WHERE CD.Conference = 'NFC' AND CD.Division = 'West';

SELECT * FROM ConferenceDivision;

SELECT T.TeamName, CD.Conference, CD.Division
FROM Team T
JOIN ConferenceDivision CD
    ON T.ConferenceDivisionID = CD.ConferenceDivisionID;