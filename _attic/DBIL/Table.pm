use 5.006;    # our
use strict;
use warnings;

package BeastForm::DBIL::Table;

our $VERSION = '0.000001';

# AUTHORITY

use BeastForm::Util qw(modulify);

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
