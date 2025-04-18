WITH series_of_losses AS (
  SELECT competition
    , team
    , from_gameweek, to_gameweek
    , to_char(from_date, 'DD-MM-YYYY') AS from_date
    , to_char(to_date, 'DD-MM-YYYY')   AS to_date
    , num_of_losses
    , DENSE_RANK() 
        OVER(PARTITION BY competition ORDER BY num_of_losses desc) 
      AS drn_num_of_losses
  FROM(
    SELECT mt1.*
    , CASE
        WHEN mt2.winner = 'Y' THEN 'Y'
        ELSE 'N'
     END AS is_loser
    FROM matchteam_vw mt1
    JOIN matchteam_vw mt2
      ON  mt1.competitionid = mt2.competitionid 
      AND mt1.matchid       = mt2.matchid 
      AND mt1.teamid       != mt2.teamid 
    WHERE mt1.competition NOT IN ('World Cup', 'European Championship')
   ) MATCH_RECOGNIZE (
      PARTITION BY competition, team
      ORDER BY dateutc
      MEASURES
        FIRST(W.dateutc)    AS from_date,
        E.dateutc           AS to_date,
        FIRST(W.gameweek)   AS from_gameweek,
        E.gameweek          AS to_gameweek,
        COUNT(*)            AS num_of_losses
      ONE ROW PER MATCH
      AFTER MATCH SKIP PAST LAST ROW
      PATTERN (W+ E) 
      DEFINE
        W AS W.winner     = 'N' 
          AND W.is_loser  = 'Y'
          AND NEXT(W.winner)    = 'N'  
          AND NEXT(W.is_loser)  = 'Y'
   )
 )
SELECT competition
    , team
    , from_gameweek, to_gameweek
    , from_date, to_date,num_of_losses
FROM series_of_losses
WHERE drn_num_of_losses = 1 
ORDER BY num_of_losses DESC
;

