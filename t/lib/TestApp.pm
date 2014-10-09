package TestApp;

=head1 NAME

TestApp - Catalyst Test App

=head1 DESCRIPTION

Catalyst Test App. Used by controller tests.

=cut

use NAP::policy qw/ test /;

use Catalyst;

__PACKAGE__->setup;

1;