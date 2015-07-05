use strict;
use warnings;
use Test::Most;
use DBIx::BeastForm::DBIL;

my $bf = DBIx::BeastForm::DBIL->new(
  namespace => 'DBIx::BeastForm::Test4',
  username => '',  password  => '',
  database => 'blogpick',  dbd  => 'Pg', 
);
is($bf->dsn, 'dbi:Pg:dbname=blogpick', 'DSN generated correctly');
isa_ok($bf->connector, 'DBIx::Connector', "Has a connector");
isa_ok($bf->schema, 'SQL::Translator::Schema', "Has a schema");
my $d = $bf->dynamic;
isa_ok($d, 'DBIx::Lite', 'creates a DBIx::Lite');
ok($bf->schema->get_tables, 'We can see at least one table');
ok($d->table('post')->single, 'There is at least one post');

throws_ok { $bf->static  } qr/patches welcome/i, 'static throws';
throws_ok { $bf->awesome } qr/patches welcome/i, 'awesome throws';

done_testing;
