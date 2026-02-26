  use MIST_RDB_Cooper; 
 
select distinct * from team;



select count(t.TEAMID) as "ID's"
from TEAM as t;



select t.TeamName, c.Conference, c.Division
from Team as t
inner join ConferenceDivision as c on T.ConferenceDivisionID=C.ConferenceDivisionID
where Conference = 'AFC' and Division = 'East';