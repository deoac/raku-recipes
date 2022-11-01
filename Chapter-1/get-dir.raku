use v6.d;

use lib "../";

class Recipes {
    has $.folder;
    has $!is-win = $*DISTRO.is-win;

    multi method show ( $self where .is-win: ) {
        shell "dir {$self.folder}"
    }

    multi method show ( $self: ) {
        shell "ls {$self.folder}";
    }
} # end class Recipes

my Recipes $recipes-folder = Recipes.new: folder => "../recipes";

$recipes-folder.show;
