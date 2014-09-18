package BookAPitch::Controller::Players;
use Moose;
use namespace::autoclean;
use DateTime;
use Catalyst::Request::Upload;

BEGIN { extends 'Catalyst::Controller'; }
my $upload_dir = "root/static/images";
my $max_size = 30_000;
=head1 NAME

BookAPitch::Controller::Players - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 base

Can place common logic to start chained dispatch here

=cut
sub base :Chained('/') :PathPart('players') :CaptureArgs(0) {
    my ($self, $c) = @_;

    # Store the ResultSet in stash so it's available for other methods
    $c->stash(resultset => $c->model('BookAPitchDB::User'));

    # Print a message to the debug log
    $c->log->debug('*** INSIDE BASE METHOD ***');
}

=head2 object

Fetch the specified player object based on the player ID and store
it in the stash

=cut

sub object :Chained('base') :PathPart('id') :CaptureArgs(1) {
    # $id = primary key of player to delete
    my ($self, $c, $id) = @_;

    # Find the book object and store it in the stash
    $c->stash(object => $c->stash->{resultset}->find($id));

    # Make sure the lookup was successful.  You would probably
    # want to do something like this in a real app:
    #   $c->detach('/error_404') if !$c->stash->{object};
    die "Player $id not found!" if !$c->stash->{object};

    # Print a message to the debug log
    $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$id ***");
}


=head2 register

Register a new plaer, this will also allow them to use the credentials in registration
in the sign in.

=cut

sub register :Chained('base') :PathPart('register') :Args(0) {
    my ($self, $c) = @_;

    $c->stash({ template => 'players/register.tt2' });
}

=head2 submit_registration

Save user information

=cut

sub submit_registration :Chained('base') :PathPart('submit_registration') :Args(0) {
    my ($self, $c) = @_;

    # Get params
    my $params = $c->request->params;

    # Ensure we don't allow any potentially dangerous files to be upload
    # Only image files are allowed.
    my $upload = $c->req->upload('user_profile_image');
    my $filename = $upload->filename;
    my $target = "root/static/images/$filename";

    # TODO: Check file types only allow images
    # png|jpeg|gif

    unless ( $upload->link_to($target) || $upload->copy_to($target) ) {
        die ( 'Failed to copy ' . $filename . ' to ' . $target , ': ' . $!);
    }


    my $user = $c->model('BookAPitchDB::User')->create({
        username      => $params->{username},
        password      => $params->{password},
        email_address => $params->{email},
        first_name    => $params->{first_name},
        last_name     => $params->{surname},
        image_url     => $upload->filename,
        mobile        => $params->{mobile},
        created       => DateTime->now,
        updated       => DateTime->now,
        active        => 1,
    });

    $c->stash({
        user => $user
    });

    $c->log->debug("About to redirect, user created " . $user->id);

    $c->response->redirect(
        $c->uri_for($c->controller('Login')->action_for('index')),
    );
}


=head2 View

View a game

=cut

sub view_profile :Chained('object') :PathPart('view_profile') :Args(0) {
    my ($self, $c) = @_;
warn "IN View Profile";
    # stash object contains the player row.

    $c->stash({
        player => $c->stash->{object},
        template => 'players/view_profile.tt2',
    });
}

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched BookAPitch::Controller::Players in Players.');
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
