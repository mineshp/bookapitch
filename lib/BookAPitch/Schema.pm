use utf8;
package BookAPitch::Schema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use Moose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces(
    result_namespace => "Result::Public",
    resultset_namespace => "ResultSet::Public",
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2014-10-04 18:00:30
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XFO5+/EIvs5m8moqflwNVQ

__PACKAGE__->load_namespaces(
    result_namespace => 'Result',
    resultset_namespace => 'ResultSet',
);

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
