use strict;
use warnings;
use Test::More;


use Catalyst::Test 'BookAPitch';
use BookAPitch::Controller::Login;

ok( request('/login')->is_success, 'Request should succeed' );
done_testing();
