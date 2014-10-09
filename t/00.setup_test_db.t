#!perl

=head1 t/00.setup_test_db.t

Setup test database for tests.

=cut
use lib 't/lib';
use strict;
use warnings;
use Try::Tiny;

use Test::More 'no_plan';

use_ok( 'Test::Database' );

eval {
    ok( Test::Database->deploy_db );
};
if ($@) {
    BAIL_OUT( "(t/00.setup.t):" . $@ );
}