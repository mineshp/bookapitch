use strict;
use warnings;
use Test::More;


use Catalyst::Test 'BookAPitch';
use BookAPitch::Controller::Site;

ok( request('/site')->is_success, 'Request should succeed' );
done_testing();
