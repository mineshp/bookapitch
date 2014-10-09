-- run this as:
--    psql -d template1 -f db_schema/01_setup_db.sql

-- CREATED database with user bookapitchuser

CREATE DATABASE bookapitchdb
    WITH    OWNER=bookapitchuser
           ENCODING='UTF8'
;

-- TODO: This should not be created here as the application itself does
-- not use it, it needs to be part of the build run.
--Create blank test database
CREATE DATABASE bookapitchtestdb
    WITH    OWNER=bookapitchuser
               ENCODING='UTF8'
;