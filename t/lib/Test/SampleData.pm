package Test::SampleData;

use strict;
use warnings;
use DateTime;

use Data::UUID;
my $ug = new Data::UUID;
my $usertoken = $ug->create_hex();

=head1 NAME

t/lib/Test/Data/SampleData.pm

=head1 DESCRIPTION

This module contains test data used for running tests within the test suite:

It will always create test data rather than attempt to find existing data in the
database.

=head1 SYNOPSIS

The subroutines in here are intended to be called as class methods, e.g.

use Test::SampleData;
Test::SampleData->foo();

=cut

=head2 test_user_data

Method to return a hashref of test user data.

=cut

sub test_user_data {

    my ( $self ) = @_;

    my $user = sprintf("test_user_%s", $usertoken);

    return {
        username      => $user,
        password      => 'password',
        email_address => $user . "\@blah.com",
        first_name    => "fname_" . $user,
        last_name     => "lname_" . $user,
        mobile        => "123456789",
        image_url     => undef,
        created       => DateTime->now,
        updated       => DateTime->now,
    };
}

=head2 setup_test_user

Method to store a test user

=cut

sub setup_test_user {
    my ( $self ) = @_;

    my $schema = $self->get_test_db_schema;

    # Create a test user
    my $user = $schema->resultset('User')->create($self->test_user_data);

    return $user;
}


=head2 get_test_db_schema

TODO: Make this read from the test config rather than hard code db details
Return schema object for test DB.

=cut
sub get_test_db_schema {
    my ( $self ) = @_;

    return BookAPitch::Schema->connect("dbi:Pg:dbname=bookapitchtestdb;", 'bookapitchuser');
}
