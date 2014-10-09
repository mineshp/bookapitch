use utf8;
package BookAPitch::Schema::ResultSet::Public::User;

use strict;
use warnings;

use DBIx::Class::ResultClass::HashRefInflator;
use Moose;
extends 'DBIx::Class::ResultSet';

=head active_users

Get all active users

=cut
sub active_users {
    my ($self, $c) = @_;

    return $self->search({ active => 1 })->all;
}

1;