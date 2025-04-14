VARIABLE cnt NUMBER
SET TERM ON
SET SERVEROUTPUT ON

EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserting into AREAS ...');
SET TERM OFF
@@insert_data/areas.sql
COMMIT;
EXECUTE SELECT COUNT(*) INTO :cnt FROM areas;
SET TERM ON
EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserted: ' || :cnt || '; Expected: 152 records.');

EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserting into COMPETITION ...');
SET TERM OFF
@@insert_data/competition.sql
COMMIT;
EXECUTE SELECT COUNT(*) INTO :cnt FROM competition;
SET TERM ON
EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserted: ' || :cnt || '; Expected: 7 records.');

EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserting into TEAM ...');
SET TERM OFF
@@insert_data/team.sql
COMMIT;
EXECUTE SELECT COUNT(*) INTO :cnt FROM team;
SET TERM ON
EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserted: ' || :cnt || '; Expected: 142 records.');

EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserting into COACH ...');
SET TERM OFF
@@insert_data/coach.sql
COMMIT;
EXECUTE SELECT COUNT(*) INTO :cnt FROM coach;
SET TERM ON
EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserted: ' || :cnt || '; Expected: 211 records.');

EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserting into PLAYER ...');
SET TERM OFF
@@insert_data/player.sql
COMMIT;
EXECUTE SELECT COUNT(*) INTO :cnt FROM player;
SET TERM ON
EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserted: ' || :cnt || '; Expected: 3618 records.');

EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserting into PLAYERROLE ...');
SET TERM OFF
@@insert_data/playerrole.sql
COMMIT;
EXECUTE SELECT COUNT(*) INTO :cnt FROM playerrole;
SET TERM ON
EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserted: ' || :cnt || '; Expected: 4 records.');

EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserting into REFEREE ...');
SET TERM OFF
@@insert_data/referee.sql
COMMIT;
EXECUTE SELECT COUNT(*) INTO :cnt FROM referee;
SET TERM ON
EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserted: ' || :cnt || '; Expected: 637 records.');

EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserting into MATCH ...');
SET TERM OFF
@@insert_data/match.sql
COMMIT;
EXECUTE SELECT COUNT(*) INTO :cnt FROM match;
SET TERM ON
EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserted: ' || :cnt || '; Expected: 1941 records.');

EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserting into MATCHTEAM ...');
SET TERM OFF
@@insert_data/matchteam.sql
COMMIT;
EXECUTE SELECT COUNT(*) INTO :cnt FROM matchteam;
SET TERM ON
EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserted: ' || :cnt || '; Expected: 3882 records.');

EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserting into MATCHPLAYER ...');
SET TERM OFF
@@insert_data/matchplayer.sql
COMMIT;
EXECUTE SELECT COUNT(*) INTO :cnt FROM matchplayer;
SET TERM ON
EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserted: ' || :cnt || '; Expected: 74098 records.');

EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserting into MATCHREFEREE ...');
SET TERM OFF
@@insert_data/matchreferee.sql
COMMIT;
EXECUTE SELECT COUNT(*) INTO :cnt FROM matchreferee;
SET TERM ON
EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserted: ' || :cnt || '; Expected: 7931 records.');

EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserting into MATCHSUBSTITUTION ...');
SET TERM OFF
@@insert_data/matchsubstitution.sql
COMMIT;
EXECUTE SELECT COUNT(*) INTO :cnt FROM matchsubstitution;
SET TERM ON
EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserted: ' || :cnt || '; Expected: 11097 records.');

EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserting into POSITION ...');
SET TERM OFF
@@insert_data/position.sql
COMMIT;
EXECUTE SELECT COUNT(*) INTO :cnt FROM position;
SET TERM ON
EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserted: ' || :cnt || '; Expected: 10205 records.');

EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserting into EVENTTYPE ...');
SET TERM OFF
@@insert_data/eventtype.sql
COMMIT;
EXECUTE SELECT COUNT(*) INTO :cnt FROM eventtype;
SET TERM ON
EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserted: ' || :cnt || '; Expected: 45 records.');

EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserting into EVENTSUBTYPE ...');
SET TERM OFF
@@insert_data/eventsubtype.sql
COMMIT;
EXECUTE SELECT COUNT(*) INTO :cnt FROM eventsubtype;
SET TERM ON
EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserted: ' || :cnt || '; Expected: 36 records.');

EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserting into EVENT ...');
SET TERM OFF
@@insert_data/event.sql
COMMIT;
EXECUTE SELECT COUNT(*) INTO :cnt FROM event;
SET TERM ON
EXECUTE  DBMS_OUTPUT.PUT_LINE('Inserted: ' || :cnt || '; Expected: 3251294 records.');
