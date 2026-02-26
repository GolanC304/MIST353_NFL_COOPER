  use MIST_RDB_Cooper; 
 
select distinct * from team;



select count(t.TEAMID) as "ID's"
from TEAM as t;



select t.TeamName, c.Conference, c.Division;
from TEAM as t
inner join ConferenceDivision t.ConferenceDivisionID=c.ConferenceDivisionID;
where CK_ConferenceNames='AFC';