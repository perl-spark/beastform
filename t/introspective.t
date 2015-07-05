use strict;
use warnings;
use Test::More;
use DBIx::BeastForm::Introspective;

my $bf = DBIx::BeastForm::Introspective->new(
  namespace => 'DBIx::BeastForm::Test3',
  username => '',  password  => '',
  database => 'blogpick',  dbd  => 'Pg', 
);
is($bf->dsn, 'dbi:Pg:dbname=blogpick', 'DSN generated correctly');
ok($bf->connector->isa('DBIx::Connector'), "Has a connector");
ok($bf->schema->isa('SQL::Translator::Schema'), "Has a schema");

done_testing;
