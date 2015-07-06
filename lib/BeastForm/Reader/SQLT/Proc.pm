package BeastForm::Reader::SQLT::Proc;

our $VERSION = '0.000001';

# AUTHORITY

use Moo;
use Beastform::Proc;

with 'BeastForm::Role::Process';

has in_proc => (
  is => 'ro', required => 1,
  handles => [ qw( sql name order owner comment params ) ],
);
has in_schema => ( is => 'ro', required => 1 );

sub go {
  my ($self) = @_;
  BeastForm::Proc->new(
    sql  => $self->sql,  order => $self->order, comment => $self->comment,
    name => $self->name, owner => $self->owner, params  => [$self->params],
  );
}
1;
__END__


