#!/usr/bin/perl
# vim: ts=8 sts=4 et sw=4 sr sta
use strict;
use warnings;
use Test::More tests => 6;
use Data::Printer;

use FindBin::libs;
use lib 't/lib';
use Test::SampleData;

use Catalyst::Test 'BookAPitch';

=head1 NAME

conrtroller_unit_root.t

=head1 DESCRIPTION

Tests behaviour of login and logout controller

TEST CASES
Accessing the application without logging in
1. Attempt to login with incorrect auth details
2. Attempt to login with correct auth details
3. Attempt to logout

=head1 METHODS

=cut

# Test controller is available
BEGIN {
    use_ok 'Catalyst::Test', 'BookAPitch';
    use_ok 'BookAPitch::Controller::Login';
    use_ok 'BookAPitch::Controller::Logout'
}

# User can access login page
ok( request('/login')->is_success, 'Request to /login page is successful' );

warn "ATTEMPT LOGIN WITH BAD DETAILS";
use HTTP::Request::Common;
my ($response, $c) = ctx_request POST '/login', [
    username => 'unknown_user',
    password => 'idontknow'
];
warn "1. POST COMPLETE";

# Check we have displayed bad username or password feedback message
is($c->stash->{error_msg}, "Bad username or password.",
    "Unable to login, bad username or password entered");

# Now attempt to setup a test user and attempt successful login.
# Our test should insert our own data, we are not testing registration here
# so insert into db.
my $testuser = Test::SampleData->setup_test_user;
warn "ATTEMPT LOGIN WITH GOOD DETAILS";
my ($response_success, $c) = ctx_request POST '/login', [
    username => $testuser->username,
    password => $testuser->password
];
warn "2. POST COMPLETE";
isnt($c->stash->{error_msg}, undef, "No error returned from login");

warn "RESP " . p $response_success->base;

warn "USER " . $testuser->username;
warn "PASS " . $testuser->password;

=pod
ok( request('/blah')->is_redirect, 'Unable to access page blah, user redirected');

#!/usr/bin/perl
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
=cut