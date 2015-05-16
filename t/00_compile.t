use strict;
use warnings;
use Test::More;


use SanrioCharacterRanking;
use SanrioCharacterRanking::Web;
use SanrioCharacterRanking::Web::View;
use SanrioCharacterRanking::Web::ViewFunctions;

use SanrioCharacterRanking::DB::Schema;
use SanrioCharacterRanking::Web::Dispatcher;


pass "All modules can load.";

done_testing;
