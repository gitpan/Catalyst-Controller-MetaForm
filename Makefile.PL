use inc::Module::Install;
  
name           'Catalyst-Controller-MetaForm';
all_from       'lib/Catalyst/Controller/MetaForm.pm';

requires       'aliased'              => 0;
requires       'Catalyst::Runtime'    => '5.71001',
requires       'Class::MetaForm'      => 0;
requires       'Moose'                => '0.79';
requires       'namespace::autoclean' => 0;

test_requires  'Test::More'           => '0.42';

WriteAll;

