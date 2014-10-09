#!/usr/bin/perl
# vim: ts=8 sts=4 et sw=4 sr sta
use NAP::policy qw/ test /;

# load the module that provides all of the common test functionality
use FindBin::libs qw( base=lib_dynamic );
use Test::DBIx::Class::Schema;

my $schematest = Test::DBIx::Class::Schema->new(
    {
        dsn       => 'dbi:Pg:dbname=bookapitchdb',
        username  => 'bookapitchuser',
        password  => undef,
        namespace => 'BookAPitch::Schema',
        moniker   => 'User',
        glue      => 'Result::Public',
        test_missing => 1,
    }
);

$schematest->methods(
    {
        columns => [
            qw[
                id
                username
                password
                email_address
                first_name
                last_name
                mobile
                image_url
                created
                updated
                active
            ]
        ],
        relations => [
            qw[
                game_players
                user_roles
            ]
        ],
        custom => [
        ],
        resultsets => [
            qw[
                active_users
            ]
        ]
    }
);

$schematest->run_tests();