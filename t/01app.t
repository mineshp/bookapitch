#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use Catalyst::Test 'BookAPitch';

ok( request('/login')->is_success, 'Request should succeed' );

done_testing();
