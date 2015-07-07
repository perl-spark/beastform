package BeastForm::Key;

use Moo;

has table   => ( is => 'ro', required => 1, weak_ref => 1);
has fields  => ( is => 'ro', required => 1 );

1;
__END__
