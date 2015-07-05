package DBIx::BeastForm::Role::Connected;

use Moo::Role;
use DBIx::Connector;

has dbd       => ( is => 'ro', required => 1  );
has database  => ( is => 'ro', required => 1  );
has username  => ( is => 'ro', default  => '' );
has password  => ( is => 'ro', default  => '' );
has extra     => ( is => 'ro', default  => sub { +{} } );
has conn_mode => ( is => 'ro', default => 'fixup');
has dbd_opts  => ( is => 'ro', default  => sub { +{RaiseError => 1, FetchHashKeyName => 'NAME_lc'} } );
has dsn       => ( is => 'lazy' );
has connector => ( is => 'lazy' );

sub _build_dsn {
  my ($self) = @_;
  my @opts;
  my %opts = (%{$self->extra}, dbname => $self->database);
  foreach my $k (sort keys %opts) {
    push @opts, sprintf("%s=%s", $k, $opts{$k});
  }
  sprintf("dbi:%s:%s", $self->dbd, join(";", @opts));
}

sub _build_connector {
  my ($self) = @_;
  my $c = DBIx::Connector->new($self->dsn, $self->username, $self->password, $self->dbd_opts);
  $c->mode($self->conn_mode);
  $c;
}

1;
__END__
