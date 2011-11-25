use Test::More;

use strict;
use warnings;

use TorontoPerlMongers::Model::Meetings;

my $meetings = TorontoPerlMongers::Model::Meetings->new();
$meetings->load("data/meetings");

ok($meetings);
ok($meetings->meetings());

done_testing();

1;