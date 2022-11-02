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

#sub MAIN ( $dir = '.' ) {
#    my @x = tree $dir;
##    pd @x;
#}

#sub MAIN ( $dir = '.' ) {
#    my @stack = $dir.IO;
#    my @raku-files = gather while @stack {
#        with @stack.pop {
#            say "=$_=";
#            when :d { say "=={$_.dir}=="; @stack.append: .dir }
#            when :f { .take when .extension.lc eq 'md'}
#        }
#    }
#    .say for @raku-files;
#    say '';
#    say tree($dir).List.flat;
#}

my$i = 0;
sub tree ( $dir ) {
    my @files;
    say "{++$i} => $dir; dir.dir => {dir $dir}; files => @files[]";
    @files = gather for dir $dir -> $f {
        if $f.IO.f {  # is it a file?
            take $f;
        } else {          # it's a directory
            take tree($f).List.flat;
        }
    }
    say --$i;
    say @files;
    return @files;
}

sub extract-titles ( $file ) {
    my @titles;
    if $file.IO.e {# does the file exist?
#        ddt $file;
        my $md = parse-markdown($file[0].slurp);
        @titles = $md.document.items
            .grep(Text::Markdown::Heading)
            .grep: {$_.level == 1};
    }
    @titles;
}
