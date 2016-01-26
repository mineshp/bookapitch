#!/usr/bin/perl
    
use strict;
use warnings;
    
use BookAPitch::Schema;
    
my $schema = BookAPitch::Schema->connect('dbi:Pg:dbname=bookapitchdb','bookapitchuser');
    
my @users = $schema->resultset('Public::User')->all;
    
foreach my $user (@users) {
    $user->password('mypass');
    $user->update;
}
