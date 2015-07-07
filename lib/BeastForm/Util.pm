package DBIx::BeastForm::Util;

use parent 'Exporter';

our @EXPORT_OK = qw(map_sth modulify make_dsn);

sub modulify {
  my ( $path, $namespace ) = @_;
  $path =~ s/[[^:lower:]]//gi;
  return $namespace . q[::] . $path;
}

sub map_sth {
  my ($self, $sth, $handler) = @_;
  my @results;
  while (my $hr = $sth->fetchrow_hashref) {
    push @results, $handler->(%$hr);
  }
  croak($sth->err) if $sth->err;
  @results;
}

sub make_dsn {
  my ($self, $driver, %opts) = @_;
  delete @opts{qw(username password user pass)};
  my $dsn = "dbi:${driver}:";
  foreach my $name (sort keys %opts) {
    $dsn .= sprintf('%s=%s;', $name, $opts{$name});
  }
  $dsn =~ s/;\z//; # Trim the last semi if present
  $dsn;
}

1
__END__
