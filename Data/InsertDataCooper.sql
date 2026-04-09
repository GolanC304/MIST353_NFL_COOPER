
GO


IF OBJECT_ID('MIST353NFLCooper_AddTeam', 'P') IS NOT NULL
    DROP PROCEDURE MIST353NFLCooper_AddTeam;
GO


GO

-- Insert ConferenceDivision 
INSERT INTO ConferenceDivision (Conference, Division)
VALUES ('AFC','East'), ('AFC','North'), ('AFC','South'), ('AFC','West'),
       ('NFC','East'), ('NFC','North'), ('NFC','South'), ('NFC','West');
GO


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


-- AFC North
INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Cleveland Browns', 'Cleveland, OH', 'Brown/Orange', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='AFC' AND Division='North';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Cincinnati Bengals', 'Cincinnati, OH', 'Black/Orange', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='AFC' AND Division='North';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Baltimore Ravens', 'Baltimore, MD', 'Purple/Black', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='AFC' AND Division='North';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Pittsburgh Steelers', 'Pittsburgh, PA', 'Black/Gold', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='AFC' AND Division='North';

-- AFC East
INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'New England Patriots', 'Boston, MA', 'Blue/White', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='AFC' AND Division='East';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Miami Dolphins', 'Miami, FL', 'Aqua/Orange', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='AFC' AND Division='East';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'New York Jets', 'New York City, NY', 'Green/White', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='AFC' AND Division='East';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Buffalo Bills', 'Buffalo, NY', 'Blue/Red/White', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='AFC' AND Division='East';

-- AFC South
INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Houston Texans', 'Houston, TX', 'Deep Red/Navy/White', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='AFC' AND Division='South';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Indianapolis Colts', 'Indianapolis, IN', 'Blue/White', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='AFC' AND Division='South';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Jacksonville Jaguars', 'Jacksonville, FL', 'Teal/Black/Gold', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='AFC' AND Division='South';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Tennessee Titans', 'Nashville, TN', 'Navy/Titanium/Red', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='AFC' AND Division='South';

-- AFC West
INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Kansas City Chiefs', 'Kansas City, MO', 'Red/Gold', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='AFC' AND Division='West';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Las Vegas Raiders', 'Las Vegas, NV', 'Silver/Black', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='AFC' AND Division='West';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Los Angeles Chargers', 'Los Angeles, CA', 'Blue/Gold', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='AFC' AND Division='West';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Denver Broncos', 'Denver, CO', 'Orange/Navy', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='AFC' AND Division='West';

-- NFC North
INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Chicago Bears', 'Chicago, IL', 'Navy/Orange', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='NFC' AND Division='North';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Detroit Lions', 'Detroit, MI', 'Blue/Silver', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='NFC' AND Division='North';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Green Bay Packers', 'Green Bay, WI', 'Green/Gold', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='NFC' AND Division='North';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Minnesota Vikings', 'Minneapolis, MN', 'Purple/Gold', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='NFC' AND Division='North';

-- NFC East
INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Dallas Cowboys', 'Arlington, TX', 'Navy/Silver/White', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='NFC' AND Division='East';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'New York Giants', 'East Rutherford, NJ', 'Blue/Red/White', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='NFC' AND Division='East';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Philadelphia Eagles', 'Philadelphia, PA', 'Midnight Green/Silver', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='NFC' AND Division='East';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Washington Commanders', 'Landover, MD', 'Burgundy/Gold', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='NFC' AND Division='East';

-- NFC South
INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Atlanta Falcons', 'Atlanta, GA', 'Red/Black/Silver', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='NFC' AND Division='South';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Carolina Panthers', 'Charlotte, NC', 'Blue/Black/Silver', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='NFC' AND Division='South';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'New Orleans Saints', 'New Orleans, LA', 'Black/Gold', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='NFC' AND Division='South';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Tampa Bay Buccaneers', 'Tampa, FL', 'Red/Pewter/White', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='NFC' AND Division='South';

-- NFC West
INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'San Francisco 49ers', 'San Francisco, CA', 'Red/Gold', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='NFC' AND Division='West';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Seattle Seahawks', 'Seattle, WA', 'Blue/Green/Silver', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='NFC' AND Division='West';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Los Angeles Rams', 'Los Angeles, CA', 'Blue/Gold', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='NFC' AND Division='West';

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
SELECT 'Arizona Cardinals', 'Glendale, AZ', 'Red/White/Black', ConferenceDivisionID
FROM ConferenceDivision
WHERE Conference='NFC' AND Division='West';