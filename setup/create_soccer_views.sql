SET TERM ON
SET SERVEROUTPUT ON

EXECUTE  DBMS_OUTPUT.PUT_LINE('Creating views ...');
SET TERM OFF

@@../views/create_matchteam_vw.sql
@@../views/create_player_substitution_vw

SET TERM ON
EXECUTE  DBMS_OUTPUT.PUT_LINE('Views created.');