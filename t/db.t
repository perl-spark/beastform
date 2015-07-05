use strict;
use warnings;
use Test::More;
use DBIx::BeastForm;
use Data::Dumper 'Dumper';

sub bf_for {
  my ($driver, $database, $user, $pass) = @_;
}

# # TODO: Make a test database so this works on everyone else's machine.
# # TODO: Make that work across multiple databases neatly and easily
# my $dsn  = $ENV{DBI_DSN} || 'dbi:Pg:dbname=blogpick';
# my $user = $ENV{DBI_USER} // '';
# my $pass = $ENV{DBI_PASS} // '';

# my $bf = DBIx::BeastForm->new(
#   namespace => 'DBIx::BeastForm::Test3',
#   user => $user,   pass     => $pass,
#   dbd  => $driver, database => $database,
# );
# bf_for('Pg', 'blogpick','','');
# $bf->make_dynamic_table_classes;
ok(1);
# my %tables = $bf->tables;
# foreach my $k (sort keys %tables) {
#   my $v = $tables{$k};
#   is($k, $v->name, "Created with the correct name: $k");
#   warn "cols=" . Dumper([$v->cols]);
# }
done_testing;
