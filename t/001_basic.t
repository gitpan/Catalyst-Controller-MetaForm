use Test::More;

use FindBin;
use lib "$FindBin::Bin/lib";

use Catalyst::Test 'TestApp';

use strict;
use warnings;

plan tests => 4;

like (get ('/foo/submit_form'),qr/NO_FORM/);

like (get ('/foo/submit_form?bar=42'),qr/GOT_FORM/);

like (get ('/foo/asserted_submit_form'),qr/FORM_ERROR/);

like (get ('/foo/asserted_submit_form?bar=42'),qr/GOT_FORM/);

