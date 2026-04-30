

/*
1. User searches for teams using Conference name (optional) and / or Division name (optional)
To show: TeamName, ConferenceName, DivisionName
*/

go


create or alter procedure procGetTeamsByConferenceDivision
(
    @ConferenceName NVARCHAR(50) = null,
    @DivisionName NVARCHAR(50) = null
)
AS
begin
    select TeamName, TeamColors, Conference, Division
    from Team T inner join ConferenceDivision C
        on T.ConferenceDivisionID = C.ConferenceDivisionID
    where Conference = IsNull(@ConferenceName, Conference)
        and Division = IsNull(@DivisionName, Division)
end
/*
execute procGetTeamsByConferenceDivision
    @ConferenceName = 'AFC',
    @DivisionName = 'North';
*/


go

create OR alter procedure procGetTeamsInSameConferenceDivisionAsSpecifiedTeam
(
    @TeamName NVARCHAR(50)
)
AS
BEGIN
    select OtherTeam.TeamName, CD.Conference, CD.Division
    from Team MyTeam inner join Team OtherTeam
        on MyTeam.ConferenceDivisionID = OtherTeam.ConferenceDivisionID
        inner join ConferenceDivision CD
        on MyTeam.ConferenceDivisionID = CD.ConferenceDivisionID
    where MyTeam.TeamName = @TeamName and
        OtherTeam.TeamName != @TeamName;
END
-- execute procGetTeamsInSameConferenceDivisionAsSpecifiedTeam @TeamName = 'Baltimore Ravens';

GO

create or alter procedure procValidateUser
(
    @Email NVARCHAR(100),
    @PasswordHash NVARCHAR(200)
)
AS
BEGIN
    select AppUserID, Firstname + ' ' + Lastname as Fullname, UserRole
    from AppUser
    where Email = @Email and 
    PasswordHash = Convert(VARBINARY(200), @PasswordHash, 1);
END
-- execute procValidateUser @Email = 'tom.brady@example.com', @PasswordHash = '0x01';
-- execute procValidateUser @Email = 'bill.belichick@example.com', @PasswordHash = '0x01';
-- select * from AppUser;

GO

create or alter procedure procGetTeamsForSpecifiedFan
(
    @NFLFanID INT
)
AS
BEGIN
    select T.TeamName, CD.Conference, CD.Division, T.TeamColors, FT.PrimaryTeam
    from FanTeam FT inner join Team T
        on FT.TeamID = T.TeamID
        inner join ConferenceDivision CD
        on T.ConferenceDivisionID = CD.ConferenceDivisionID
    where FT.NFLFanID = @NFLFanID;
end;
-- execute procGetTeamsForSpecifiedFan @NFLFanID = 1;
-- execute procGetTeamsForSpecifiedFan @NFLFanID = 2;

go

create or alter procedure procScheduleGame
(
    @HomeTeamID INT,
    @AwayTeamID INT,
    @GameRound NVARCHAR(50),
    @GameDate DATE,
    @GameStartTime TIME,
    @StadiumID INT,
    @NFLAdminID INT -- the logged-in admin who is scheduling the game
)
AS
BEGIN
    -- Store the NFLAdminID in context so that the trigger can access it when inserting into AdminChangesTracker
    declare @context VARBINARY(128) = cast(@NFLAdminID as VARBINARY(128)); -- int is only 4 bytes, but context_info can store up to 128 bytes, so we can store additional info in the future if needed
    SET context_info @context;

    insert into Game (HomeTeamID, AwayTeamID, GameRound, GameDate, GameStartTime, StadiumID)
    values (@HomeTeamID, @AwayTeamID, @GameRound, @GameDate, @GameStartTime, @StadiumID);
END

/*
GameRound: 'Wild Card', HomeTeamID: 22, AwayTeamID: 30, GameDate: '2026-01-10', GameStartTime: '16:30', StadiumID: 22, 
NFLAdminID for scheduling: 5 (Bill Belichick)

execute procScheduleGame 
    @HomeTeamID = 22, 
    @AwayTeamID = 30, 
    @GameRound = 'Wild Card', 
    @GameDate = '2026-01-10', 
    @GameStartTime = '16:30', 
    @StadiumID = 22, 
    @NFLAdminID = 5;


GameRound: 'Wild Card', HomeTeamID: 17, AwayTeamID: 19, GameDate: '2026-01-10', GameStartTime: '20:00', StadiumID: 17,
NFLAdminID for scheduling: 6 (Sean McVay)

execute procScheduleGame 
    @HomeTeamID = 17, 
    @AwayTeamID = 19, 
    @GameRound = 'Wild Card', 
    @GameDate = '2026-01-10', 
    @GameStartTime = '20:00', 
    @StadiumID = 17, 
    @NFLAdminID = 6;

delete from Game where GameID = 12;
select * from Game order by GameID desc;
select * from AdminChangesTracker order by AdminChangesTrackerID desc;


*/

go

-- trigger to track changes made by NFLAdmin to the Game table
-- 1. triggering event (insert, update, delete) on Game table
-- 2. action: insert a record into AdminChangesTracker with NFLAdminID, GameID, ChangeType, ChangeDescription

create or alter trigger trgTrackChangesOnSchedulingGame
on Game
after insert
as
BEGIN
    declare @NFLAdminID INT;
    declare @GameID INT;
    declare @ChangeType NVARCHAR(50);
    declare @ChangeDescription NVARCHAR(500);
    declare @GameRound NVARCHAR(50);
    declare @GameDate DATE;
    declare @GameStartTime TIME;
    declare @HomeTeamID INT;
    declare @AwayTeamID INT;
    declare @HomeTeamName NVARCHAR(50);
    declare @AwayTeamName NVARCHAR(50);
    declare @StadiumID INT;
    declare @StadiumName NVARCHAR(100);
    declare @AdminFullName NVARCHAR(100);

    -- get the NFLAdminID from context
    set @NFLAdminID = convert(int, convert(binary(4),context_info()));

    -- get the GameID of the newly inserted game
    select @GameID = GameID, @GameRound = GameRound, @GameDate = GameDate, @GameStartTime = GameStartTime, 
        @HomeTeamID = HomeTeamID, @AwayTeamID = AwayTeamID, @StadiumID = StadiumID
    from inserted;
    select @HomeTeamName = TeamName from Team where TeamID = @HomeTeamID;
    select @AwayTeamName = TeamName from Team where TeamID = @AwayTeamID;
    select @StadiumName = StadiumName from Stadium where StadiumID = @StadiumID;
    select @AdminFullName = Firstname + ' ' + Lastname from AppUser where AppUserID = @NFLAdminID;

    set @ChangeType = 'Insert';
    set @ChangeDescription = @AdminFullName + ' scheduled a new game with GameID ' + cast(@GameID as NVARCHAR(50))
        + ': ' + @HomeTeamName + ' vs ' + @AwayTeamName + ' on ' + cast(@GameDate as NVARCHAR(50)) 
        + ' at ' + cast(@GameStartTime as NVARCHAR(50)) + ' in stadium  ' + @StadiumName
        + '. Game round: ' + @GameRound;

    insert into AdminChangesTracker (NFLAdminID, GameID, ChangeType, ChangeDescription)
    values (@NFLAdminID, @GameID, @ChangeType, @ChangeDescription);
END

go

create or alter procedure procGetAllChangesMadeBySpecifiedAdmin
(
    @NFLAdminID INT
)
as
begin
    select ACT.ChangeDateTime, ACT.ChangeType, ACT.ChangeDescription, 
    G.GameRound, G.GameDate, G.GameStartTime,
    HT.TeamName as HomeTeam, AT.TeamName as AwayTeam, S.StadiumName
    from AdminChangesTracker ACT inner join Game G
        on ACT.GameID = G.GameID
        inner join Team HT
        on G.HomeTeamID = HT.TeamID
        inner join Team AT
        on G.AwayTeamID = AT.TeamID
        inner join Stadium S
        on G.StadiumID = S.StadiumID
    where ACT.NFLAdminID = @NFLAdminID
    order by ACT.ChangeDateTime desc;
end

-- execute procGetAllChangesMadeBySpecifiedAdmin @NFLAdminID = 5; -- Bill Belichick

GO

create or alter procedure procEnterGameScore
(
    @GameID INT,
    @HomeTeamScore INT,
    @AwayTeamScore INT,
    @NFLAdminID INT
)
AS
BEGIN

-- Store the AdminID in context so the trigger can read it
    DECLARE @context VARBINARY(128) = CAST(CAST(@NFLAdminID AS BINARY(4)) AS VARBINARY(128));
    SET CONTEXT_INFO @context;

    update Game
    set HomeTeamScore = @HomeTeamScore,
        AwayTeamScore = @AwayTeamScore,
        WinningTeamID = CASE 
            WHEN @HomeTeamScore > @AwayTeamScore THEN HomeTeamID
            WHEN @AwayTeamScore > @HomeTeamScore THEN AwayTeamID
        END
    where GameID = @GameID;
END

GO

create or alter trigger trgTrackChangesOnEnteringGameScore
ON Game
AFTER UPDATE
AS
BEGIN
    -- Only proceed if score columns were touched
    IF UPDATE(HomeTeamScore) OR UPDATE(AwayTeamScore)
    BEGIN
        DECLARE @GameID         INT,  
                @NFLAdminID     INT,
                @HomeTeamScore  INT, @AwayTeamScore  INT, @WinningTeamID INT,
                @HomeTeamName NVARCHAR(50), @AwayTeamName NVARCHAR(50), @WinningTeamName NVARCHAR(50),
                @ChangeDescription  NVARCHAR(500),
                @ChangeType NVARCHAR(50),
                @AdminFullName NVARCHAR(100);

        SELECT  @GameID        = GameID,
                @HomeTeamScore = HomeTeamScore,
                @AwayTeamScore = AwayTeamScore,
                @WinningTeamID = WinningTeamID                
        FROM inserted;

        select @HomeTeamName = T.TeamName from Team T join Game G on T.TeamID = G.HomeTeamID where G.GameID = @GameID;
        select @AwayTeamName = T.TeamName from Team T join Game G on T.TeamID = G.AwayTeamID where G.GameID = @GameID;
        select @WinningTeamName = T.TeamName from Team T where T.TeamID = @WinningTeamID;

        -- Read the AdminID that was stored by the procedure
        SET @NFLAdminID = CONVERT(INT, CONVERT(BINARY(4), CONTEXT_INFO()));
        select @AdminFullName = Firstname + ' ' + Lastname from AppUser where AppUserID = @NFLAdminID;


        set @ChangeType = 'Update';
        SET @ChangeDescription =
            'Scores updated by ' + @AdminFullName + ' for GameID=' + CAST(@GameID AS NVARCHAR(10))
            + ': Home=' + @HomeTeamName + ' (' + CAST(@HomeTeamScore AS NVARCHAR(10)) + ')'
            + ', Away=' + @AwayTeamName + ' (' + CAST(@AwayTeamScore AS NVARCHAR(10)) + ')'
            + ', WinningTeam=' + @WinningTeamName;
            
        insert into AdminChangesTracker (NFLAdminID, GameID, ChangeDateTime, ChangeType, ChangeDescription)
        values (@NFLAdminID, @GameID, GETDATE(), @ChangeType, @ChangeDescription);
    END
END

GO

/*
select * from TeamStadium;
select * from Game order by GameID desc;
select * from AdminChangesTracker order by AdminChangesTrackerID desc;
*/