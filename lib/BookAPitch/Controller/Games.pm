package BookAPitch::Controller::Games;
use Moose;
use namespace::autoclean;
use Try::Tiny;
use Data::Printer;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

BookAPitch::Controller::Games - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 base

Can place common logic to start chained dispatch here

=cut
sub base :Chained('/') :PathPart('games') :CaptureArgs(0) {
    my ($self, $c) = @_;

    # Store the ResultSet in stash so it's available for other methods
    $c->stash(resultset => $c->model('BookAPitchDB::Game'));

    # Print a message to the debug log
    $c->log->debug('*** INSIDE BASE METHOD ***');
}

=head2 object

Fetch the specified game object based on the game ID and store
it in the stash

=cut

sub object :Chained('base') :PathPart('id') :CaptureArgs(1) {
    # $id = primary key of book to delete
    my ($self, $c, $id) = @_;

    # Find the book object and store it in the stash
    $c->stash(object => $c->stash->{resultset}->find($id));

    # Make sure the lookup was successful.  You would probably
    # want to do something like this in a real app:
    #   $c->detach('/error_404') if !$c->stash->{object};
    die "Game $id not found!" if !$c->stash->{object};

    # Print a message to the debug log
    $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$id ***");
}


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched BookAPitch::Controller::Games in Games.');
}

=head2 list

Fetch all game objects and pass to games/list.tt2 in stash to be displayed.

=cut

sub list :Local {
    my ( $self, $c ) = @_;

    $c->stash({
        games => [$c->model('BookAPitchDB::Game')->all],
        template => 'games/list.tt2',
    });
}

sub create :Chained('base') :PathPart('create') :Args(0) {
    my ($self, $c) = @_;
=pod
    my $game = $c->model('BookAPitch::Game')->create({
        name => $game_name,
        status => $status
    });

    $c->stash({
        game => $game,
        template => 'games/game_created.tt2'
    });

    # Disable caching for this page
    $c->response->header('Cache-Control' => 'no-cache');
=cut

    $c->stash({ template => 'games/create_game.tt2' });
}

=head2 form_create_do

Take information from form and add to database

=cut
sub form_create_do :Chained('base') :PathPart('form_create_do') :Args(0) {
    my ($self, $c) = @_;

    # Retrieve the values from the form
    my $name      = $c->request->params->{game_name};
    my $game_date = $c->request->params->{scheduled_for};

    # Create the game
    my $game = $c->model('BookAPitchDB::Game')->create({
        name   => $name,
        scheduled => $game_date,
    });

    # Store new model object in stash and set template
    $c->stash(
        game     => $game
    );

    # TODO: Method to display feedback messages
    #$c->stash->{feedback_error} = 1 if $error;
    $c->stash->{feedback_success} =
        sprintf("Game %s created and scheduled for %s",
            $game->name, $game->scheduled) if $game;

    # Redirect the user back to the view game page with status msg as an arg
    $c->response->redirect($c->uri_for($self->action_for('view'),
        {id => $game->id, status_msg => "Game created."}));
}

=head2 View

View a game

=cut

sub view :Chained('object') :PathPart('view') :Args(0) {
    my ($self, $c) = @_;

    # stash object contains the game row.

    $c->stash({
        game => $c->stash->{object},
        template => 'games/view.tt2',
    });
}


=head2 delete

Delete a game

=cut

sub delete :Chained('object') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    # Use the book object saved by 'object' and delete it along
    # with related 'game_players' entries
    $c->stash->{object}->delete;

    # Set a status message to be displayed at the top of the view

    # Redirect the user back to the list page with status msg as an arg
    $c->response->redirect($c->uri_for($self->action_for('list'),
        {status_msg => "Game deleted."}));
}


=head2 invite_players

Invite players to a game

=cut

sub invite_players :Chained('object') :PathPart('invite') :Args(0) {
    my ($self, $c) = @_;

    # Find all active users
    my $all_users = $c->model('BookAPitchDB::Users')->active_users;

    $c->log->debug("Sending emails to the following users: ");
    foreach ( $all_users ) {
        $c->log->debug($_->email_address)
    }
    $c->log->debug("_____________END_______________");
    # Send email to users, create template to send email to users.

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
