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

-- AFC NORTH
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

-- AFC EAST
insert into Team(TeamName,TeamCityState,TeamColors, ConferenceDivisionID)
select 'New England Patriots', 'Boston, MA', 'Blue/White', ConferenceDivisionID
from ConferenceDivision
where Conference = 'AFC' AND Division = 'East';

insert into Team(TeamName,TeamCityState,TeamColors, ConferenceDivisionID)
select 'Miami Dolphins', 'Miami, FL', '', ConferenceDivisionID
from ConferenceDivision
where Conference = 'AFC' AND Division = 'East';

insert into Team(TeamName,TeamCityState,TeamColors, ConferenceDivisionID)
select 'New York Jets', 'New York City, NY', '', ConferenceDivisionID
from ConferenceDivision
where Conference = 'AFC' AND Division = 'East';

insert into Team(TeamName,TeamCityState,TeamColors, ConferenceDivisionID)
select 'Buffalo Bills', 'Buffalo, NY', '', ConferenceDivisionID
from ConferenceDivision
where Conference = 'AFC' AND Division = 'East';

-- NFC North
insert into Team(TeamName,TeamCityState,TeamColors, ConferenceDivisionID)
select 'Greenbay Packers', 'Greenbay, WI', '', ConferenceDivisionID
from ConferenceDivision
where Conference = 'NFC' AND Division = 'North';

insert into Team(TeamName,TeamCityState,TeamColors, ConferenceDivisionID)
select 'Chicago Bears', 'Chicago, IL', '', ConferenceDivisionID
from ConferenceDivision
where Conference = 'NFC' AND Division = 'North';

insert into Team(TeamName,TeamCityState,TeamColors, ConferenceDivisionID)
select 'Detriot Lions', 'Detriot, MI', '', ConferenceDivisionID
from ConferenceDivision
where Conference = 'NFC' AND Division = 'North';

insert into Team(TeamName,TeamCityState,TeamColors, ConferenceDivisionID)
select 'Minnisota Vikings', 'Minneapolis, MN', '', ConferenceDivisionID
from ConferenceDivision
where Conference = 'NFC' AND Division = 'North';

-- NFC East
insert into Team(TeamName,TeamCityState,TeamColors, ConferenceDivisionID)
select 'Dallas Cowboys', 'Dallas, TX', '', ConferenceDivisionID
from ConferenceDivision
where Conference = 'NFC' AND Division = 'East';

insert into Team(TeamName,TeamCityState,TeamColors, ConferenceDivisionID)
select 'Philadelphia Eagles', 'Philadelphia, PA', '', ConferenceDivisionID
from ConferenceDivision
where Conference = 'NFC' AND Division = 'East';

insert into Team(TeamName,TeamCityState,TeamColors, ConferenceDivisionID)
select 'New York Giants', 'New York City, NY', '', ConferenceDivisionID
from ConferenceDivision
where Conference = 'NFC' AND Division = 'East';

insert into Team(TeamName,TeamCityState,TeamColors, ConferenceDivisionID)
select 'Washington Commanders', 'Ashburn, VA', '', ConferenceDivisionID
from ConferenceDivision
where Conference = 'NFC' AND Division = 'East';
