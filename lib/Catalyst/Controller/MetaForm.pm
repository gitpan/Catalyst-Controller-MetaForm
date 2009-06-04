package Catalyst::Controller::MetaForm;

use base qw/Catalyst::Controller/;

use Catalyst::Controller::MetaForm::Action::Form;
use Class::MOP;

use strict;
use warnings;

our $VERSION = '0.01_01';

sub create_action {
  my ($self,%args) = @_;

  if ($args{ attributes }{ metaform }) {
    $args{ attributes }{ ActionClass } = [ 'Catalyst::Controller::MetaForm::Action::Form' ];
  }

  return $self->next::method (%args);
}

sub _parse_Form_attr {
  my ($self,$app,$name,$value) = @_;

  return metaform => { form_class => $self->_expand_form_name ($app,$value) };
}

sub _parse_AssertForm_attr {
  my ($self,$app,$name,$value) = @_;

  return metaform => { assert => 1,form_class => $self->_expand_form_name ($app,$value) };
}

sub _expand_form_name {
  my ($self,$app,$form_name) = @_;

  $form_name = "$app\::Form::$form_name" unless $form_name =~ s/^\+//;

  Class::MOP::load_class ($form_name);

  return $form_name;
}

sub form_error : Private {}

1;

__END__

=pod

=head1 NAME

Catalyst::Controller::MetaForm - MetaForm sugar for Catalyst

=head1 SYNOPSIS

  package MyApp::Form::Login;

  use Moose;
  use Class::MetaForm;

  has username => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
  );

  has password => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
  );

  package MyApp::Controller::Auth;

  use base qw/Catalyst::Controller::MetaForm/;

  use strict;
  use warnings;

  # This will require the form MyApp::Form::Login to be successfully
  # validated before the code gets to execute.

  sub login : Local AssertForm('Login') Args(0) {
    my ($self,$c,$form) = @_;
  }

  # In this case, the form MyApp::Form::Something doesn't have to be
  # valid in order for the action to execute.

  sub somethingelse : Local Form('Something') Args(0) {
    my ($self,$c,$form) = @_;

    # $form will be undefined if it wasn't successfully validated
  }

  1;

=head1 SEE ALSO

=over 4

=item L<Catalyst>

=item L<Class::MetaForm>

=back

=head1 BUGS

Most software has bugs. This module probably isn't an exception. 
If you find a bug please either email me, or add the bug to cpan-RT.

=head1 AUTHOR

Anders Nor Berle E<lt>berle@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2009 by Modula AS

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

