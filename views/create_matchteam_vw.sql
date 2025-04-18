--DROP VIEW matchteam_vw;
CREATE VIEW matchteam_vw AS
  SELECT c.competitionid
    , c.name      AS competition
    , m.matchid
    , m.dateutc
    , m.gameweek
    , t.teamid
    , t.name      AS team
    , mt.winner
    , mt.score
    , mt.side
    , co.coachid
    , co.lastname AS coach
  FROM competition c
    JOIN match     m  ON c.competitionid = m.competitionid
    JOIN matchteam mt ON mt.matchid      = m.matchid
    JOIN team      t  ON mt.teamid       = t.teamid
    JOIN coach     co ON co.coachid      = mt.coachid;