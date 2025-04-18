SET TERM ON
SET SERVEROUTPUT ON

EXECUTE  DBMS_OUTPUT.PUT_LINE('Creating views ...');
SET TERM OFF

@@../views/create_matchteam_vw.sql

SET TERM ON
EXECUTE  DBMS_OUTPUT.PUT_LINE('Views created.');