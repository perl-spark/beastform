use Test::Most;
use BeastForm::Reader::SQLT;
use DBIx::Connector;
use Data::Dumper 'Dumper';

my $c = DBIx::Connector->new('dbi:Pg:dbname=beastform','','');
my $s = BeastForm::Reader::SQLT->new( connector => $c )->go;
isa_ok( $s, 'BeastForm::Schema' );
is_deeply( [$s->tables->keys], [qw(test1 test2 test3 test4)] , "We see all tables" );
# is( scalar $s->views->keys,    1, "We see all views" );
# is( scalar $s->procs->keys,    1, "We see all procs" );
# is( scalar $s->triggers->keys, 1, "We see all triggers" );
# is( $s->name, 'beastform' );
# @tables = ($tables[0]);
my $ti = $s->tables->iterator;
{
  my ($key, $t) = $ti->();
  is($key, 'test1', "Got test1 first");
  isa_ok($t->pk, 'BeastForm::Key', 'PK is a BeastForm::Key');
  is_deeply([map $_->name, @{$t->pk->fields}], [ qw( id ) ]);
  diag("Field tests:");
  my $fi = $t->fields->iterator;
  {
    my ($k2, $f) = $fi->();
    is($k2, 'id');
    ($k2, $f) = $fi->();
    is($k2, 'text_field');
    ok(!$fi->(), "No more fields");
  }
# These should all be accompanied by further checks
# They should then be replicated across all tables
# If in doubt refer to the sql
  is (scalar $t->keys->keys, 0, "There are no keys on test1");
#   is (scalar $t->checks->keys, 1, "There is one check constraint on test");
#   is (scalar $t->indices->keys, 1, "There is one index on test");
  is (scalar $t->outs->keys, 0, "There are no outs on test1");
  is (scalar $t->ins->keys, 2, "There are two ins on test1");
}
{
  my ($key, $t) = $ti->();
  is($key, 'test2', "Got test2 next");
  # diag("Field tests:");
  # my $fi = $t->fields->iterator;
  # {
  #   my ($k2, $f) = $fi->();
  #   is($k2, 'id');
  #   ($k2, $f) = $fi->();
  #   is($k2, 'test1_id');
  #   ok(!$fi->(), "No more fields");
  # }
  is (scalar $t->keys->keys, 0, "There are no keys on test2");
#  is (scalar $t->outs->keys, 0, "There are no outs on test2");
}
{
  my ($key, $t) = $ti->();
  is($key, 'test3', "Then test3");
#  is (scalar $t->keys->keys, 1, "There is one key on test3");
#  is (!$t->outs->keys, 0, "There are no outs on test3");

#   diag("Field tests:");
#   my $fi = $t->fields->iterator;
#   {
#     my ($k2, $f) = $fi->();
#     is($k2, 'id');
#     ($k2, $f) = $fi->();
#     is($k2, 'unique_int');
#     ($k2, $f) = $fi->();
#     is($k2, 'registered');
#     ($k2, $f) = $fi->();
#     is($k2, 'extra');
#     ok(!$fi->(), "No more fields");
#   }
}
{
  my ($key, $t) = $ti->();
  is($key, 'test4', "Finally test4");
#  is (scalar $t->keys->keys, 1, "There is one key on test4");
#  is (scalar $t->outs->keys, 0, "There are no outs on test4");
#   my $fi = $t->fields->iterator;
#   {
#     my ($k2, $f) = $fi->();
#     is($k2, 'test1_id');
#     ($k2, $f) = $fi->();
#     is($k2, 'test2_id');
#     ($k2, $f) = $fi->();
#     is($k2, 'unique_int');
#     ok(!$fi->(), "No more fields");
#   }
}
# while ( my ( $name, $t ) = $ti->() ) {
#    diag("Got table: '$name'");
#    ok(! ref $t->name, "Name is a string");
# }
# foreach my $t (@tables) {
#   
# }
# foreach my $v (@views) {
#   diag("Got view: ", $v->name);
# }
# foreach my $p (@procs) {
#   diag("Got proc: ", $p->name);
# }
# foreach my $t (@triggers) {
#   diag("Got trigger: ", $t->name);
# }

done_testing;
