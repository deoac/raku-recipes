use v6.d;

use lib "../";

class Recipes {
    has $.folder;
    has $.folder-path = IO::Path.new: $!folder;
    has $!is-win = $*DISTRO.is-win;

    multi method show ( $self where .is-win:) {
        shell "dir {$self.folder-path}"
    }

    multi method show {
        shell "ls {self.folder-path}";
    }
} # end class Recipes

my Recipes $recipes-folder = Recipes.new: folder => "../recipes";

say $recipes-folder.folder;
say $recipes-folder.folder-path.raku;

$recipes-folder.show;

