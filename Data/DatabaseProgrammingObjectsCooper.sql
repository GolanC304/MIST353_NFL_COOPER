  use MIST_RDB_Cooper; 
 
select distinct * from team;



select count(t.TEAMID) as "ID's"
from TEAM as t;

select t.TEAMNAME
from TEAM as t
where t.ConferenceDivision='AFC';
