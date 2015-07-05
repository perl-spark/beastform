use strict;
use warnings;
use Test::More;
use DBIx::BeastForm::Connected;

my $bf = DBIx::BeastForm::Connected->new(
  namespace => 'DBIx::BeastForm::Test2',
  username => '',  password  => '',
  database => 'blogpick',  dbd  => 'Pg', 
);
is($bf->dsn, 'dbi:Pg:dbname=blogpick');
ok($bf->connector->isa('DBIx::Connector'), "Has a connector");

done_testing;
