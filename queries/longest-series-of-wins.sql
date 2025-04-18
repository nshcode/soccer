WITH series_of_wins AS (
  SELECT competition
    , team
    , from_gameweek
    , to_gameweek
    , TO_CHAR(from_date, 'DD-MM-YYYY') AS from_date
    , TO_CHAR(to_date, 'DD-MM-YYYY')   AS to_date
    , num_of_wins
    , DENSE_RANK() 
        OVER(PARTITION BY competition ORDER BY num_of_wins desc) 
      AS drn_num_of_wins
FROM(
  SELECT * FROM matchteam_vw
  WHERE competition NOT IN ('World Cup', 'European Championship')
 ) MATCH_RECOGNIZE (
    PARTITION BY competition, team 
    ORDER BY dateutc
    MEASURES
      FIRST(W.dateutc)    AS from_date,
      E.dateutc           AS to_date,
      FIRST(W.gameweek)   AS from_gameweek,
      E.gameweek          AS to_gameweek,
      COUNT(*)            AS num_of_wins
    ONE ROW PER MATCH
    PATTERN (W+ E) 
    DEFINE
      W AS W.winner = 'Y' AND NEXT(W.winner) = 'Y'
  )
)
SELECT competition
  , team
  , from_gameweek, to_gameweek
  , from_date, to_date,num_of_wins
FROM series_of_wins
WHERE drn_num_of_wins = 1 
ORDER BY num_of_wins DESC
;

