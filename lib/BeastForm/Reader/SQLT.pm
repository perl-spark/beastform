package BeastForm::Reader::SQLT;

# ABSTRACT: Uses L<SQL::Translator> to introspect a database

use Moo;
use SQL::Translator;
use BeastForm::Reader::SQLT::Schema;

with 'BeastForm::Role::Process';

has connector => ( is => 'ro', required => 1 );

sub _sqlt {
  my ($self) = @_;
  my $sqlt = SQL::Translator->new(
    parser => 'DBI', parser_args => { dbh => $self->connector->dbh },
  );
  $sqlt->translate;
  $sqlt;
}

sub go {
  my ($self) = @_;
  BeastForm::Reader::SQLT::Schema->new(
    in_schema => $self->_sqlt->schema
  )->go;
}

1;
__END__
