SELECT  team
    , coach
    , from_week
    , to_week
    , new_coach
    , mnum
FROM (
    SELECT * FROM matchteam_vw
    WHERE competition NOT IN ('World Cup', 'European Championship')
  ) MATCH_RECOGNIZE (
      PARTITION BY competition, team
      ORDER BY dateutc
      MEASURES
        S.coach             AS coach,
        S.gameweek          AS from_week,
        CASE
          WHEN LAST(C.gameweek) IS NOT NULL THEN LAST(C.gameweek)
          ELSE S.gameweek
        END                 AS to_week,
        NEW_C.coach         AS new_coach,
        MATCH_NUMBER()      AS mnum
      ONE ROW PER MATCH
      AFTER MATCH SKIP TO NEW_C
      PATTERN(S C* NEW_C) 
      DEFINE
        C     AS C.coach = PREV(C.coach),
        NEW_C AS NEW_C.coach != S.coach        
  )
WHERE competition LIKE 'Spanish%' 
ORDER BY team
;
