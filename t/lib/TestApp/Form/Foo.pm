package TestApp::Form::Foo;

use Moose;

use Class::MetaForm;

has bar => (
  is       => 'ro',
  isa      => 'Int',
  required => 1,
);

1;

