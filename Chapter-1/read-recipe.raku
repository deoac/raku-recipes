#!/usr/bin/env raku
use v6.d;

use Text::Markdown;

say $*CWD;
say @*ARGS;
sub MAIN ( $file ) {
    say $file;
    say $file.IO.e;
    if $file.IO.e {
        my $md = parse-markdown-from-file $file;
        say "Recipe Title: ", $_.text, ~ ', ' ~ $_.level
            for $md.document.items
                .grep: Text::Markdown::Heading;
#                .grep({ $_.level == 1 });
    }
}