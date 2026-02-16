USE MIST_RDB_Cooper;

insert into ConferenceDivision (Conference, Division)
VALUES
('AFC', 'East'),
('AFC', 'West'),
('AFC', 'North'),
('AFC', 'South'),
('NFC', 'East'),
('NFC', 'West'),
('NFC', 'North'),
('NFC', 'South');

insert into Team(TeamName,TeamCityState,TeamColors, ConferenceDivisionID)
select 'Cleveland Browns', 'Cleveland, OH,', 'Brown/Orange', ConferenceDivisionID
from ConferenceDivision
where Conference = 'AFC' AND Division = 'North';

insert into Team(TeamName,TeamCityState,TeamColors, ConferenceDivisionID)
select 'Cincinnati Bengals', 'Cincinnati, OH', 'Black/Orange', ConferenceDivisionID
from ConferenceDivision
where Conference = 'AFC' AND Division = 'North';

insert into Team(TeamName,TeamCityState,TeamColors, ConferenceDivisionID)
select 'Baltimore Ravens', 'Baltimore, MD ', 'Purple/Black',ConferenceDivisionID
from ConferenceDivision
where Conference = 'AFC' AND Division = 'North';

insert into Team(TeamName,TeamCityState,TeamColors, ConferenceDivisionID)
select 'Pittsburgh Steelers', 'Pittsburgh, PA', 'Black/Gold', ConferenceDivisionID
from ConferenceDivision
where Conference = 'AFC' AND Division = 'North';


