use 5.006;    # our
use strict;
use warnings;

package BeastForm::Schema;

our $VERSION = '0.000001';

# AUTHORITY

use Moo;


has name     => ( is => 'ro', required => 1 );
has procs    => ( is => 'ro', required => 1 );
has views    => ( is => 'ro', required => 1 );
has tables   => ( is => 'ro', required => 1 );
has triggers => ( is => 'ro', required => 1 );

1;
__END__
