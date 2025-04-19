
CREATE VIEW player_substitution_vw AS
SELECT c.competitionid
  , c.name            AS competition
  , m.matchid
  , m.dateutc
  , t.teamid
  , t.name             AS team
  , pin.playerid       AS plalyerinid
  , pin.lastname       AS playerin
  , pout.playerid      AS playeroutid 
  , pout.lastname      AS playerout
FROM competition c
JOIN match m              ON c.competitionid = m.competitionid
JOIN matchsubstitution ms ON m.matchid = ms.matchid
JOIN team t               ON ms.teamid = t.teamid
JOIN player pin           ON pin.playerid = ms.playerinid
JOIN player pout          ON pout.playerid = ms.playeroutid
;