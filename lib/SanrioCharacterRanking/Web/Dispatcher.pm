package SanrioCharacterRanking::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

use SanrioCharacterRanking::M::Vote;

get '/' => sub {
    my ($c) = @_;
    my @ranking = SanrioCharacterRanking::M::Vote->ranking;
    return $c->render('index.tx', {
        ranking => \@ranking,
    });
};

1;
