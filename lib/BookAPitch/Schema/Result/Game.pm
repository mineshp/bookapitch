use utf8;
package BookAPitch::Schema::Result::Game;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

BookAPitch::Schema::Result::Game

=cut

use strict;
use warnings;
use Data::Printer;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::PassphraseColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "PassphraseColumn");

=head1 TABLE: C<games>

=cut

__PACKAGE__->table("games");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'games_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 scheduled

  data_type: 'timestamp with time zone'
  is_nullable: 1

=head2 status

  data_type: 'text'
  default_value: 'IN PROGRESS'
  is_nullable: 0

=head2 created

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 updated

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "games_id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 1 },
  "scheduled",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "status",
  { data_type => "text", default_value => "IN PROGRESS", is_nullable => 0 },
  "created",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "updated",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 game_players

Type: has_many

Related object: L<BookAPitch::Schema::Result::GamePlayer>

=cut

__PACKAGE__->has_many(
  "game_players",
  "BookAPitch::Schema::Result::GamePlayer",
  { "foreign.game_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2014-08-15 15:00:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:YqsHOu/Pbyle5r82iYh8FA

=head2 add_players_to_game

Add players to a game, helper method.

=cut
sub add_players_to_game {
    my ($self) = @_;

    # Get all active users

    my @users =
        $self->result_source->schema->resultset('BookAPitch::Schema::Result::User')->active_users;

    foreach my $user( @users) {
        # Add players to game_players
        $self->game_players->create({
            game_id => $self->id,
            player_id => $user->id,
        });
        warn "Adding user " . $user->email_address;
    }
}

=head2 available_players

Players that have confirmed that they are available

=cut
sub available_players {
    my ($self) = @_;

    my @available_players = $self->game_players->search({
        player_status => 'AVAILABLE',
    });

    return \@available_players;
}

=head2 unavailable_players

Players that have confirmed that they are unavailable

=cut
sub unavailable_players {
    my ($self) = @_;

    my @unavailable_players = $self->game_players->search({
        player_status => 'UNAVAILABLE',
    });

    return \@unavailable_players;
}

=head2 pending_players

Players that have failed to confirm whether they are available or unavailable.

=cut
sub pending_players {
    my ($self) = @_;

    my @pending_players = $self->game_players->search({
        player_status => 'PENDING',
    });

    return \@pending_players;
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
