package BeastForm::Reader::SQLT::View;

use Moo;
use BeastForm::View;

with 'BeastForm::Role::Process';

has in_view => (
  is => 'ro', required => 1,
  handles => [ qw( sql name order ) ], # Cheap getters
);
has in_schema => ( is => 'ro', required => 1 );

sub fields  { [ shift->in_view->fields  ]; }
sub tables  { [ shift->in_view->tables  ]; }
sub options { [ shift->in_view->options ]; }

sub go {
  my ($self) = @_;
  BeastForm::View->new(
    sql  => $self->sql,  order  => $self->order,  tables  => $self->tables,
    name => $self->name, fields => $self->fields, options => $self->options,
  );
}

1;
__END__
