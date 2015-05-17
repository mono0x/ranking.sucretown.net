package SanrioCharacterRanking::DB::Schema;
use strict;
use warnings;
use utf8;

use Teng::Schema::Declare;

base_row_class 'SanrioCharacterRanking::DB::Row';

table {
    name 'statuses';
    pk 'id';
    columns qw(id created_at source);
};

table {
    name 'characters';
    pk 'id';
    columns qw(id name);
};

table {
    name 'votes';
    pk qw(character_id status_id);
    columns qw(character_id status_id);
};

1;
