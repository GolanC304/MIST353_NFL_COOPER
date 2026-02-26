  use MIST_RDB_Cooper; 
 
select distinct * from team;



select count(t.TEAMID) as "ID's"
from TEAM as t;


create procedure NFLTeamNames
@NFLTeam nvarchar(50) 
@NFLCity nvarchar(50)




select t.TeamName, c.Conference, c.Division, t.TeamColors
from Team as t
inner join ConferenceDivision as c on T.ConferenceDivisionID=C.ConferenceDivisionID
where Conference = 'AFC' and Division = 'East';



declare @myTeamName nvarchar(50) = 'New England Patriots';


select OtherTeam.TeamName
from Team MyTeam
inner join  Team OtherTeam.ConferenceDivisionID on MyTeam.ConferenceDivisionID=OtherTeam.ConferenceDivisionID
where MyTeam.TeamName =@myTeamName AND OtherTeam.TeamName != @myTeamName;
