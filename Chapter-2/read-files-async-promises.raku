#!/usr/bin/env raku
use v6.d;

use Text::Markdown;
use PrettyDump;
use Data::Dump::Tree;

sub MAIN ( $dir = '.' ) {
   my $x = tree($dir);
   my Promise @promises = do
       for tree($dir).List.flat -> $f {
           start extract-titles $f;
       }

    my @results = await @promises;
    say "Recipes →\n\t", @results.map( *.chomp).join: "\t";
}

sub tree ( $dir ) {
    my @files;
    @files = gather for dir $dir -> $f {
        if $f.IO.d {      # is it a directory?
            take tree($f).List.flat;
        } else {          # it's a file
            take $f;
        }
    }
    return @files;
}

sub extract-titles ( $file ) {
    my @titles;
    if $file.IO.e {     # does the file exist?
        my $md = parse-markdown($file[0].slurp);
        say "************* $file *************" if $md;
        @titles = $md.document.items
            .grep(Text::Markdown::Heading)
            .grep: {$_.level == 1};
    }
    @titles;
}
