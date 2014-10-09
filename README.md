
NAME
        BookAPitch

DESCRIPTION
        Web application to allow players to confirm availability for weekly
        football games. Show overall status of game.

SETUP

## Development

### Setup Database
* Create postgres database called bookapitchdb
    psql -d template1 -U postgres -f db_schema/01_setup_db.sql

* Dump sql file into blank database we just created
    psql -U bookapitchuser -d bookapitchdb -f db_schema/02_setup_schema_model.sql
    psql -U bookapitchuser -d bookapitchtestdb -f ../../db_schema/02_setup_schema_model.sql

#* Dump data to database
#    psql -U www -d upload -f db_schema/03_setup_data.sql

* Generate schema files automatically, by reading from our database
    perl db_schema/04_schema_loader.pl


## Production


IMPORTANT NOTES
        If you update database model, by adding or removing tables and columns,
        ensure you update db_schema/04_schema_loader.pl and rerun
        perl db_schema/04_schema_loader.pl

	When running tests and you need a testdb, use the following to set the testDB credentials.
	APP_DB="dbi:Pg:dbname=bookapitchtestdb" prove -lv t/*

AUTHORS
