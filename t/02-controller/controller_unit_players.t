#!/usr/bin/perl
# vim: ts=8 sts=4 et sw=4 sr sta
use NAP::policy qw/ test /;

# Test controller is available
BEGIN { use_ok 'Upload::Controller::Players' }

{
    no warnings;
    *FakeModel::view_profile = sub { return shift->{days} };
    my $model = bless { days=>5 }, 'FakeModel';
    *FakeContext::model = sub {return $model};
    *FakeContext::stash = sub {return shift->{stash}};
}

my $context = bless { stash=> {} } , 'FakeContext';

Cheer::Controller::Root::index( undef, $context );
is_deeply ($context->stash, {'template' => 'hi_there.tt','days_till_xmas' => 5}, 'checked stash');