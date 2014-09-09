use strict;
use warnings;

use BookAPitch;

my $app = BookAPitch->apply_default_middlewares(BookAPitch->psgi_app);
$app;

