
use strict;
use warnings;

use Test::More;

# ABSTRACT: Make sure build_bins returns expected values

use regulars qw( build_bins );

my %bins;

build_bins(\%bins);

ok(exists $bins{'day'},   'day bin');
ok(exists $bins{'month'}, 'month bin');
ok(exists $bins{'week'},  'week bin');

cmp_ok(scalar @{ $bins{'day'} },   ">", 10, 'day bin > 10 items');
cmp_ok(scalar @{ $bins{'month'} }, ">", 10, 'month bin > 10 items');
cmp_ok(scalar @{ $bins{'week'} },  ">", 10, 'week bin > 10 items');

is($bins{day}->[-1],   '1995-05-27', "Oldest day bin");
is($bins{month}->[-1], '1995-05',    "Oldest month");
is($bins{week}->[-1],  '1995-W21',   "Oldest week");

done_testing;

