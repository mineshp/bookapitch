use strict;
use warnings;
use Test::More;


use Catalyst::Test 'BookAPitch';
use BookAPitch::Controller::Games;

ok( request('/games')->is_success, 'Request should succeed' );
done_testing();
