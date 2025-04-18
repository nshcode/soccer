SELECT competition
  , team
  , from_gameweek
  , to_gameweek
  , to_char(from_date, 'DD-MM-YYYY') AS from_dae
  , to_char(to_date, 'DD-MM-YYYY')   AS to_date
  , num_of_wins
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
    AFTER MATCH SKIP PAST LAST ROW
    PATTERN (W+ E) 
    DEFINE
      W AS W.winner = 'Y' 
        AND NEXT(W.winner) = 'Y'
        AND NEXT(W.gameweek) - W.gameweek = 1,
      E AS E.gameweek - PREV(E.gameweek) = 1
 )
WHERE team = 'Bayern München' 
ORDER BY from_date
;

