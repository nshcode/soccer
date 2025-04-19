WITH player_sub_out_in AS ( 
  SELECT competition
      , team
      , Player_out
      , Player_in
      , frequency
       , DENSE_RANK() 
          OVER(PARTITION BY competition ORDER BY frequency desc) 
        AS frequency_drn
  FROM (
    SELECT * FROM player_substitution_vw
    WHERE competition IN ('World Cup', 'European Championship')
    ) MATCH_RECOGNIZE (
      PARTITION BY competition
      ORDER BY team, playerout, playerin
      MEASURES
        S.team       AS team,
        S.playerin   AS Player_in,
        S.playerout  AS Player_out,
        COUNT(*)     AS frequency
      ONE ROW PER MATCH
      PATTERN (S P*) 
      DEFINE
        P AS  P.playerin = PREV(P.playerin)
          AND P.playerout = PREV(P.playerout)
          AND P.team      = PREV(P.team)
   )
 )
SELECT competition
    , team
    , Player_out
    , Player_in
    , frequency
FROM player_sub_out_in
WHERE frequency_drn in (1, 2)
 ;
 