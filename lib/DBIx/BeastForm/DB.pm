package DBIx::BeastForm::DB;

use Moo;
use DBIx::Connector;
use DBIx::BeastForm::Table;
use DBIx::BeastForm::Util qw(map_sth);
use Carp qw(croak);
use feature ':5.10';

# ABSTRACT: Logical representation of a database

has dsn => (
  is => 'ro',
  isa => sub {
    local $_ = shift || '';
    croak("Expected string, got: '$_'") if ref $_ || !$_;
  },
  required => 1,
);

has user => (
  is => 'ro',
  default => sub {''},
  isa => sub {
    local $_ = shift || '';
    croak("Expected string, got: '$_'") if ref $_;
  },
);

has pass => (
  is => 'ro',
  default => sub {''},
  isa => sub {
    local $_ = shift || '';
    croak("Expected string, got: '$_'") if ref $_;
  },
);

has mode => (
  is => 'ro',
  default => sub {'fixup'},
  isa => sub {
    local $_ = shift || '';
    croak("Expected one of qw(fixup ping no_ping), got: '$_'")
      unless /\A(?:fixup|(?:no_)?ping)\Z/;
  },
);

has options => (
  is => 'ro',
  default => sub { +{ RaiseError => 1, FetchHashKeyName => 'NAME_lc' } },
);

has connector => (
  is => 'lazy',
);

has procedures => (
  is => 'lazy',
);

has schema => (
  is => 'lazy',
);

has tables => (
  is => 'lazy',
);


sub _build_schema {
  my ($self) = @_;
  my $sqlt = SQL::Translator->new(
    parser => 'DBI', parser_args => { dbh => $self->connector->dbh },
  );
  $sqlt->schema;
}


sub name {
  my ($self) = @_;
  $self->schema->name;
}

sub _build_tables {
  my ($self) = @_;
  my @ts = $self->schema->get_tables;
  foreach my $t (@ts) {
#	DBIx::BeastForm::Table->setup($t, $self->schema);
  }
}

# sub dbs {
#   my ($self) = @_;
#   map {
#     DBIx::BeastForm::DB->new(
#       dsn => $self->dsn, user => $self->user, pass => $self->pass,
#       mode => $self->mode, connector => $self->connector,
#       options => $self->options,
#     );
#   } $self->connector->dbh->data_sources($self->name),
# }

1;
__END__
