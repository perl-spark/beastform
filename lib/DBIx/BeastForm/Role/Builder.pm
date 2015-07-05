package DBIx::BeastForm::Role::Builder;

use Moo::Role;

has schema => ( is => 'ro', required => 1 );
requires qw(_table _view _procedure _trigger _pre _post);

sub build {
  my ($self) = @_;
  $self->_pre;
  $self->_table($self->schema->get_table($_))
    foreach $self->schema->get_tables;
  $self->_view($_)
    foreach $self->schema->get_views;
  $self->_procedure($_)
    foreach $self->schema->get_procedures;
  $self->_trigger($_)
    foreach $self->schema->get_triggers;
  $self->_post;
}

1;
__END__
