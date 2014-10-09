package Test::Database;

use strict;
use warnings;
use Config::General;
use Data::Printer;

=head1 NAME

Test::Database - Test framework helper methods

=head1 DESCRIPTION

A selection of helper methods for things like test database setup and teardown.

=head1 methods

=cut


use Test::More;

=head2 deploy_db

Deploy test database

=cut
sub deploy_db {
    my $class = shift;

    # Get test database details, for creation.
    my $test_database_config = $class->_get_test_db_config;
    # Create test database with credentials

    my $dbname = $test_database_config->{ dbname };
    my $user   = $test_database_config->{ user };
    my $host   = $test_database_config->{ host };
    my $dbpass = $test_database_config->{ dbpass };

    my $db_connect = `system(psql -U $user -d $dbname);`;
    if ( $db_connect =~ /ddd/ ) {

    }
    else {

    }

    # Dump test sql file for populating tables

    return 1;
}

=head2 _get_test_db_config

Read global config file and extract test database.

=cut

sub _get_test_db_config {
    my ($self) = @_;

    my $config_file = Config::General->new("conf/application.conf");
    my %config = $config_file->getall;

    my $test_database_config = %{ config }->{database}->{test_database};

    return $test_database_config;
}

1;