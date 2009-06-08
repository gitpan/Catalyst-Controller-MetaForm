package Catalyst::Controller::MetaForm::Action::Form;

use Moose;

extends qw/Catalyst::Action/;

has assert => (
  is      => 'ro',
  isa     => 'Bool',
  default => 0,
);

has form_class => (
  is       => 'ro',
  isa      => 'Str',
  required => 1,
);

around BUILDARGS => sub {
  my ($next,$self,@args) = @_;

  my $args = $self->$next (@args);

  return { %$args,%{ $args->{ attributes }->{ metaform }->[0] } };
};

around execute => sub {
  my ($next,$self,$controller,$c,@args) = @_;

  my $form = eval { $self->form_class->new ($c->req->params) };

  if (my $e = $@) {
    if (blessed $e && $e->isa ('Class::MetaForm::Exception')) {
      $c->stash->{ form_error } = $e->simple_message;

      $c->log->debug ("$e") if $c->debug;

      $c->detach ($controller->action_for ('form_error')) if $self->assert;
    } else {
      die $e;
    }
  } else {
    $c->stash->{ form } = $form;
  }

  return $self->$next ($controller,$c,@args);
};

1;

