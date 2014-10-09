package BookAPitch::Controller::Login;
use Moose;
use namespace::autoclean;
use Data::Printer;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

BookAPitch::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    # Get the username and password from form
    my $username = $c->request->params->{username};
    my $password = $c->request->params->{password};
warn "IN index LOGIN.pm";
    if ( $c->req->method eq 'POST' ) {
warn "IN POST";
warn "USER " . $username;
warn "password " . $password;
        # If the username and password values were found in form
        if ($username && $password) {
            # Attempt to log the user in
            warn "AUTH " . $c->authenticate({ username => $username, password => $password });
            if ($c->authenticate({ username => $username,
                                       password => $password  } )) {
                warn "REDIRECTING";
                # If successful, then let them use the application
                $c->response->redirect($c->uri_for(
                    $c->controller('Players')->action_for('view_profile'),
                    [$c->user->id]));
                return;
            } else {
                # Set an error message
                warn "BAD PWD";
                $c->stash(error_msg => sprintf("Bad username: %s or password: %s.",
                    $username, $password));
            }
        } else {
            warn "EMPTY PWD";
            # Set an error message
            $c->stash(error_msg => "Empty username or password.")
                unless ($c->user_exists);
        }
        warn "NO DETAILS SUBMITTED";
        # If either of above don't work out, send to the login page
    }
    $c->stash(template => 'login.tt2');
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
