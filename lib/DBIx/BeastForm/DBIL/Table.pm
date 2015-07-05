package DBIx::BeastForm::DBIL::Table;

use DBIx::BeastForm::Util qw(modulify);

use Package::Variant
  importing => [ 'Moo' ],
  subs => [ qw(extends has after) ];

sub make_variant_package_name {
  my ($self, $ns, $schema, $table) = @_;
  sprintf("%s::%s", $ns, modulify($table->name));
}

sub make_variant {
  my ($self, $ns, $schema, $table) = @_;
  warn ("Table name:" . $table->name . "\n");
}


1;
__END__
