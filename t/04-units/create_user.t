#!perl

=head1 NAME

t/04-units/create_user.t

=head1 DESCRIPTION

Test the creation of a user.

=cut

use strict;
use warnings;
use Data::Printer;
use Test::Class;
use Test::SampleData;



# Create test data, with unique data everytime.
my $test_user_details = Test::SampleData->test_user_data;