package TestApp::Controller::Foo;

use Moose;

BEGIN { extends qw/Catalyst::Controller::MetaForm/ };

sub submit_form : Local Form('Foo') Args(0) {
  my ($self,$c,$form) = @_;

  if (defined $form) {
    $c->res->body ('GOT_FORM');
  } else {
    $c->res->body ('NO_FORM');
  }

  return;
}

sub asserted_submit_form : Local AssertForm('Foo') Args(0) {
  my ($self,$c,$form) = @_;

  $c->res->body ('GOT_FORM');

  return;
}

sub form_error : Private {
  my ($self,$c) = @_;

  $c->res->body ('FORM_ERROR');

  return;
}

1;

