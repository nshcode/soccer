
--DROP USER soccer CASCADE;

CREATE USER soccer IDENTIFIED BY soccer;
GRANT CONNECT TO soccer;
GRANT RESOURCE TO soccer;
GRANT CREATE VIEW TO soccer;

ALTER USER soccer DEFAULT TABLESPACE users;
ALTER USER soccer QUOTA 1G ON users;
ALTER USER soccer TEMPORARY TABLESPACE temp;


