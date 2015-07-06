use 5.006;    # our
use strict;
use warnings;

package BeastForm::Constraint::Check;

our $VERSION = '0.000001';

# AUTHORITY

use Moo;
with 'BeastForm::Constraint';

has sql => ( is => 'ro', required => 1 );

1;
__END__
