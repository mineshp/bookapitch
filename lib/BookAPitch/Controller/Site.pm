package BookAPitch::Controller::Site;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

BookAPitch::Controller::Site - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched BookAPitch::Controller::Site in Site.');
}

=head2 test

=cut

sub test :Local {
    my ( $self, $c ) = @_;

    $c->stash(
        username => 'Minesh',
        template => 'site/test.tt'
    );
}


=encoding utf8

=head1 AUTHOR

Minesh Patel

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
