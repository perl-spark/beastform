package BeastForm::Schema;

use Moo;


has name     => ( is => 'ro', required => 1 );
has procs    => ( is => 'ro', required => 1 );
has views    => ( is => 'ro', required => 1 );
has tables   => ( is => 'ro', required => 1 );
has triggers => ( is => 'ro', required => 1 );

1;
__END__
