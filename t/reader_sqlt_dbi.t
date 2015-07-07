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
  is($key, 'test1');
  my $fi = $t->fields->iterator;
  {
    my ($k2, $f) = $fi->();
    is($k2, 'id');
    ($k2, $f) = $fi->();
    is($k2, 'text_field');
    ok(!$fi->(), "No more fields");
  }
}
{
  my ($key, $t) = $ti->();
  is($key, 'test2');
  my $fi = $t->fields->iterator;
  {
    my ($k2, $f) = $fi->();
    is($k2, 'id');
    ($k2, $f) = $fi->();
    is($k2, 'test1_id');
    ok(!$fi->(), "No more fields");
  }
}
{
  my ($key, $t) = $ti->();
  is($key, 'test3');
  my $fi = $t->fields->iterator;
  {
    my ($k2, $f) = $fi->();
    is($k2, 'id');
    ($k2, $f) = $fi->();
    is($k2, 'unique_int');
    ($k2, $f) = $fi->();
    is($k2, 'registered');
    ($k2, $f) = $fi->();
    is($k2, 'extra');
    ok(!$fi->(), "No more fields");
  }
}
{
  my ($key, $t) = $ti->();
  is($key, 'test4');
  my $fi = $t->fields->iterator;
  {
    my ($k2, $f) = $fi->();
    is($k2, 'test1_id');
    ($k2, $f) = $fi->();
    is($k2, 'test2_id');
    ($k2, $f) = $fi->();
    is($k2, 'unique_int');
    ok(!$fi->(), "No more fields");
  }
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
