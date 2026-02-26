GO 


select * from Team;

/*
CREATE PROCEDURE MIST353NFLCooper_AddTeam
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
*/

/*
DECLARE @myTeamName NVARCHAR(50) = 'New England Patriots';

SELECT OtherTeam.TeamName
FROM Team AS MyTeam
INNER JOIN Team AS OtherTeam ON MyTeam.ConferenceDivisionID = OtherTeam.ConferenceDivisionID
WHERE MyTeam.TeamName = @myTeamName 
  AND OtherTeam.TeamName != @myTeamName;
GO
*/
/*
select OtherTeam.TeamName
from Team MyTeam
inner join  Team OtherTeam.ConferenceDivisionID on MyTeam.ConferenceDivisionID=OtherTeam.ConferenceDivisionID
where MyTeam.TeamName =@myTeamName AND OtherTeam.TeamName != @myTeamName;
*/

