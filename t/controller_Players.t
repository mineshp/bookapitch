use strict;
use warnings;
use Test::More;


use Catalyst::Test 'BookAPitch';
use BookAPitch::Controller::Players;

ok( request('/players')->is_success, 'Request should succeed' );
done_testing();
