package BeastForm::Constraint::Check;

use Moo;
with 'BeastForm::Constraint';

has sql => ( is => 'ro', required => 1 );

1;
__END__
