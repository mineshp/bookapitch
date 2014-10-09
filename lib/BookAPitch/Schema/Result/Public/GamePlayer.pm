use utf8;
package BookAPitch::Schema::Result::Public::GamePlayer;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

BookAPitch::Schema::Result::Public::GamePlayer

=cut

use strict;
use warnings;

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

=head1 TABLE: C<game_players>

=cut

__PACKAGE__->table("game_players");

=head1 ACCESSORS

=head2 game_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 player_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 player_status

  data_type: 'text'
  default_value: 'PENDING'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "game_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "player_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "player_status",
  { data_type => "text", default_value => "PENDING", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</game_id>

=item * L</player_id>

=back

=cut

__PACKAGE__->set_primary_key("game_id", "player_id");

=head1 RELATIONS

=head2 game

Type: belongs_to

Related object: L<BookAPitch::Schema::Result::Public::Game>

=cut

__PACKAGE__->belongs_to(
  "game",
  "BookAPitch::Schema::Result::Public::Game",
  { id => "game_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 player

Type: belongs_to

Related object: L<BookAPitch::Schema::Result::Public::User>

=cut

__PACKAGE__->belongs_to(
  "player",
  "BookAPitch::Schema::Result::Public::User",
  { id => "player_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2014-10-04 18:00:30
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jJVENI/V19o1wugWZNqyWw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
