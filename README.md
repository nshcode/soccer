# Soccer Data
## Introduction
The repository provides soccer data in a relational format and SQL scripts to load the data into an Oracle Database. 
The original data is available in JSON format at https://doi.org/10.6084/m9.figshare.c.4415000  and is well-described at https://www.nature.com/articles/s41597-019-0247-7

The data refers to the 2017/2018 season of five national soccer competitions in Europe: the English First Division, the French First Division, the German First Division, the Italian First Division, and the Spanish First Division. Additionally, the dataset includes data from the UEFA World Cup 2018 and the UEFA European Cup 2016.

## How to install
  1. Make sure that your working directory is the setup directory.
  2. If there are ZIP files in the  ./insert_data directory, unzip them. The unzipped files must stay in ./insert_data.
  3. Start a command shell.
  4. Set the environment variable NLS_LANG to AMERICAN_AMERICA.UTF8.
       -  For Windows Shell execute: `set NLS_LANG=AMERICAN_AMERICA.UTF8`
       -  For Linux Shell execute:   `export NLS_LANG=AMERICAN_AMERICA.UTF8`
  5. If you want to create a new schema (user), start SQL*Plus as a user who can create a new schema and run the script create_schema.sql 
       `sqlplus> @create_schema.sql`
     
     It makes a user named soccer and grants him the necessary privileges.
  7. Connect to the user you want to load the data for.
  8. Run the script install_soccer.sql
     
       `sqlplus> @install_soccer.sql`
     
     It executes the following scripts.
       * create_soccer_tables.sql
       * insert_soccer_data.sql
       * add_keys.sql
         
     Be aware that inserting the EVENT data takes a relatively longer time than inserting the other data. The EVENT table has 3,251,294 records.
