#!/usr/bin/env perl

=head1 NAME

schema_loader.pl - generate DBIC classes from the database

=head1 SYNOPSIS

When new tables are added ensure this file gets updated.


perl db_schema/04_schema_loader.pl

    --force (Ignores the "Checksum mismatch" if an auto-generated part of a file
             has been modified outside of this loader.
             Sets the 'overwrite_modifications' option in DBIx::Class::Schema::Loader)

=cut

use strict;
use warnings;

use DBIx::Class::Schema::Loader qw/ make_schema_at /;
use Getopt::Long;
use FindBin::libs qw( base=lib_dynamic );

my $override;
GetOptions(
    'force' => \$override,
);

my %map = (
    # Schema Upload
    Public => {
        db_schema => 'public',
        # Tables to dump in this schema
        constraint => qr/ ^(?:
            users |
            games |
            game_players |
            role |
            user_role |
        )$ /x,
    },
);

while ( my ($ns, $opts) = each %map) {
    make_schema_at(
        'BookAPitch::Schema',
        {
            dump_directory => './lib',
            use_namespaces => 1,
            result_namespace => "Result::$ns",
            resultset_namespace => "ResultSet::$ns",
            components => ["InflateColumn::DateTime", "PassphraseColumn"],
            naming => 'v8',
            overwrite_modifications => $override, # if -force is used
            qualify_objects => 0, # Prepend the db_schema to table names upload.event
            %$opts,
        },
        [
            'dbi:Pg:dbname="bookapitchdb"','bookapitchuser',
        ],
    );
    BookAPitch::Schema->_loader_invoked(0);
}