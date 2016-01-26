package BookAPitch;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    -Debug
    ConfigLoader
    Email
    Static::Simple

    StackTrace
    Authentication

    Session
    Session::Store::File
    Session::State::Cookie
/;

extends 'Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in bookapitch.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'BookAPitch',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
    enable_catalyst_header => 1, # Send X-Catalyst header
);

__PACKAGE__->config(
    # Configure the view
    'View::HTML' => {
        # Set the location for the TT files
        INCLUDE_PATH => [
            __PACKAGE__->path_to( 'root', 'src' ),
        ],
    }
);

# Configure SimpleDB Authentication
__PACKAGE__->config(
    'Plugin::Authentication' => {
        default => {
            class           => 'SimpleDB',
            user_model      => 'BookAPitchDB::User',
            # self_check will only work if you have the following
            # __PACKAGE__->add_columns(
            #    'password' => {
            #    passphrase       => 'rfc2307',
            #    passphrase_class => 'SaltedDigest',
            #    passphrase_args  => {
            #        algorithm   => 'SHA-1',
            #        salt_random => 20.
            #    },
            #    passphrase_check_method => 'check_password',
            #    },
            #);
            # In your Schema::Result::Public::User
            password_type   => 'self_check',
        },
    },
);

# Configure email sending
# e.g using smtp, __PACKAGE__->config->{email} = [qw/SMTP smtp.oook.de/];
__PACKAGE__->config->{email} = ['Sendmail'];

# Start the application
__PACKAGE__->setup();

=encoding utf8

=head1 NAME

BookAPitch - Catalyst based application

=head1 SYNOPSIS

    script/bookapitch_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<BookAPitch::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Minesh Patel

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
