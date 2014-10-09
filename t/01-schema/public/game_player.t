#!/usr/bin/perl
# vim: ts=8 sts=4 et sw=4 sr sta
use NAP::policy qw/ test /;

# load the module that provides all of the common test functionality
use FindBin::libs;
use Test::DBIx::Class::Schema;

my $schematest = Test::DBIx::Class::Schema->new(
    {
        dsn       => 'dbi:Pg:dbname=bookapitchdb',
        username  => 'bookapitchuser',
        password  => undef,
        namespace => 'BookAPitch::Schema',
        moniker   => 'GamePlayer',
        glue      => 'Result::Public',
        test_missing => 1,
    }
);

$schematest->methods(
    {
        columns => [
            qw[
                game_id
                player_id
                player_status
            ]
        ],
        relations => [
            qw[
                game
                player
            ]
        ],
        custom => [
        ],
        resultsets => [
            qw[

            ]
        ]
    }
);

$schematest->run_tests();