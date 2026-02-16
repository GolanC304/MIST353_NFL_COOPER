SELECT distinct t.TeamName, c.Conference, c.Division
FROM Team t
JOIN ConferenceDivision c
    ON t.ConferenceDivisionID = c.ConferenceDivisionID
WHERE c.Conference = 'AFC' AND c.Division = 'North';