package SanrioCharacterRanking::M::Vote;
use strict;
use warnings;
use utf8;
use 5.012;

use parent qw/SanrioCharacterRanking::M/;

use Amon2::Declare;

sub ranking {
    my ($class) = @_;
    c()->db->search_by_sql(
        q{SELECT characters.name AS character_name, COUNT(statuses.id) AS votes FROM statuses JOIN votes ON votes.status_id = statuses.id JOIN characters ON characters.id = votes.character_id GROUP BY characters.name ORDER BY votes desc;});
}

1;
