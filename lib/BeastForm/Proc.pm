package BeastForm::Proc;

use Moo;

has sql     => ( is => 'ro', required => 1 );
has name    => ( is => 'ro', required => 1 );
has order   => ( is => 'ro', required => 1 );
has owner   => ( is => 'ro', required => 1 );
has params  => ( is => 'ro', required => 1 );
has comment => ( is => 'ro', required => 1 );

1;
__END__


