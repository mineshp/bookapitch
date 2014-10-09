#!/usr/bin/perl
# vim: ts=8 sts=4 et sw=4 sr sta
use strict;
use warnings;
use Test::More tests => 6;

use FindBin::libs;
use Catalyst::Test 'BookAPitch';
=head1 NAME

conrtroller_unit_root.t

=head1 DESCRIPTION

Tests behaviour of root controller

TEST CASES
Accessing the application without logging in
1. If you go to the root of the application -> redirect to login page
2. User can acess /login
3. User can access /players/register

=head1 METHODS

=cut

# Test controller is available
BEGIN {
    use_ok 'Catalyst::Test', 'BookAPitch';
    use_ok 'BookAPitch::Controller::Root'
}

ok( request('/blah')->is_redirect, 'Unable to access page blah, user redirected');

# User can not view root of the application, without logging in.
my $res = request('/'); # redirects to /login
use URI;
my $uri = URI->new($res->header('location'));
# User is redirected to login page
is( $uri->path, '/login');

# User can access login page
ok( request('/login')->is_success, 'Request to /login is successful' );

# User can access new user registration page
ok( request('/players/register')->is_success, 'Request to /players/register is successful' );
