use v6.d;

use PrettyDump;
use Data::Dump::Tree;

my $those = 'those';
my $files = 'files';
my $num-files = @*ARGS.elems;

die "No files or directories specified!" if $num-files == 0;
if $num-files == 1 {
    $those = 'that';
    $files = 'file';
}

my @all-lines = $*ARGFILES.lines;
# Only consider lines that begin with a letter.  This will eliminate
# blank lines, comments, and .md Headers.
@all-lines .= grep: {/^ <:L> /};
my $all-lines = @all-lines.join: "\n";

# split the lines on either 1) a period or 2) two vertical spaces
my @sentences = $all-lines.split: / ['.' | \v** 2]/;
# `split` adds a blank line, so get rid of it.
@sentences.pop;

my $are = 'are';
my $sentences = 'sentences';

my UInt $num-sentences = @sentences.elems;
if $num-sentences == 1 {
    $are = 'is';
    $sentences = 'sentence';
}

say "There $are $num-sentences $sentences in $those $num-files $files.";

