#!/usr/bin/perl
# vim: ts=8 sts=4 et sw=4 sr sta
use strict;
use warnings;
use Test::More tests => 10;
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

use HTTP::Request::Common;
my ($response, $c) = ctx_request POST '/login', [
    username => 'unknown_user',
    password => 'idontknow'
];

# Check we have displayed bad username or password feedback message
is($c->stash->{error_msg}, "Username unknown_user does not exist, please check spelling!",
    "Unable to login, bad username or password entered");

# Now attempt to setup a test user and attempt successful login.
# Our test should insert our own data, we are not testing registration here
# so insert into db.
my $testuser = Test::SampleData->setup_test_user;

my ($response_success, $c) = ctx_request POST '/login', [
    username => $testuser->username,
    password => 'password',
];

is($c->stash->{error_msg}, undef, "No error returned from login");

my $url = $response_success->header( 'location' )->as_string;
is($url, "http://localhost/players/id/".$testuser->id."/view_profile",
    "User successfully logged in, redirected to user profile");

ok( $c->user_exists, "User exists" );

# Test logout
my $res = request('/logout'); # redirects to /logout

use URI;
my $uri = URI->new($res->header('location'));
is ( $uri->path , '/login', 'User logged out, presented with login page');

my $content = get($uri->path);
like( $content, qr/You need to log in to use this application./,
    'User asked to login to the application' );