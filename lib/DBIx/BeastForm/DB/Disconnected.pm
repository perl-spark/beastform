package DBIx::BeastForm::DB::Disconnected;

use Moo;

has dsn => (
  is => 'ro',
  isa => sub {local $_ = shift; croak("Expected string, got: $_") if ref $_ || !$_ ;},
  required => 1,
);

1;
__END__
