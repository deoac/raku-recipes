#!/usr/bin/env raku

use v6.d;

sub MAIN ( $dir = '.' ) {
   my $supply = supply tree-emit($dir);
   my @titles = gather {
       $supply.tap: -> $f { take $f, "\n\t", $f.IO.lines.head };
   }

   say "Recipes → \n",  @titles.join: "\n";
}

sub tree-emit ( $dir ) {
        for dir $dir -> $f {
            next unless $f.IO.r;
            if $f.IO.d {
                tree-emit $f;
            } else {
                next unless $f.extension.lc eq 'md';
                emit $f;
            }
        }
}
