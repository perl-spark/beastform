use strict;
use warnings;
use Test::More;
use DBIx::BeastForm;

ok( scalar DBIx::BeastForm->find_drivers, "There is at least one DBD installed" );

done_testing;