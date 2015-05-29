package SanrioCharacterRanking::M::Status;
use strict;
use warnings;
use utf8;
use 5.012;

use parent qw/SanrioCharacterRanking::M/;

use Amon2::Declare;

sub register {
    my ($class, $status) = @_;
    
}

sub bulk_register {
    my ($class, $statuses) = @_;
    for $status (@$statuses) {
        $class->register($status);
    }
}

sub _parse {
    my ($class, $status) = @_;
    return undef unless ($status->{text} =~ /サンリオキャラクター大賞で(.+?)に投票したよ/);
    $1;
}

1;
