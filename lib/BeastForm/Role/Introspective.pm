use 5.006;    # our
use strict;
use warnings;

use strict;
use warnings;

package DBIx::BeastForm::Role::Introspective;

our $VERSION = '0.000001';

# AUTHORITY

use Moo::Role;
use SQL::Translator;

with 'DBIx::BeastForm::Role::Connected';

has schema => ( is => 'lazy' );

sub _build_schema {
  my ($self) = @_;
  my $s = SQL::Translator->new( parser => 'DBI', parser_args => { dbh => $self->connector->dbh } );
  $s->translate;
  $s->schema;
}

1;
__END__
