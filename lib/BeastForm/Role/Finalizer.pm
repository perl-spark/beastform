use 5.006;    # our
use strict;
use warnings;

package BeastForm::Role::Finalizer;

our $VERSION = '0.000001';

# AUTHORITY

use Moo::Role;

requires 'finalize_a';

1;
__END__
