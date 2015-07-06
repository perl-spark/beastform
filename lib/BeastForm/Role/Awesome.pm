use 5.006;    # our
use strict;
use warnings;

package BeastForm::Role::Awesome;

our $VERSION = '0.000001';

# AUTHORITY

use Moo::Role;
use BeastForm::Schema;

with 'DBIx::BeastForm::Role::Introspective';

has aweschema => (is => 'lazy');

sub table {

}

sub _build_aweschema {
  my ($self) = @_;
  BeastForm::Awesome::Schema->from_sqlt_schema($self->schema);
}

sub dynamic {
  my ($self) = @_;
  $self->aweschema->dynamic;
}

sub static {
  die("static is not currently implemented. Patches welcome!");
}

1;
__END__ 
