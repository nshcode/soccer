SET TERM ON
SET SERVEROUTPUT ON

EXECUTE  DBMS_OUTPUT.PUT_LINE('Adding Key Constraints ...');
SET TERM OFF

@@add_keys/add_primary_keys.sql
@@add_keys/add_foreign_keys.sql

SET TERM ON
EXECUTE  DBMS_OUTPUT.PUT_LINE('Keys added.');