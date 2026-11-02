#!/usr/bin/env zsh

# Compare installed Arch Linux packages with the lists in arch/.
# The lists live in the private dotfiles-private repository because this one is public.
# This script never removes packages.

set -e

SCRIPT_NAME="${0:t}"
DOTFILES_DIR="${0:A:h:h}"
PKG_LIST="$DOTFILES_DIR/arch/pkglist.txt"
AUR_LIST="$DOTFILES_DIR/arch/aurlist.txt"

export LC_ALL=C

usage() {
    echo "Usage: $SCRIPT_NAME <command>"
    echo "  status   Show listed packages that are missing and installed packages that are not listed"
    echo "  install  Install missing packages (AUR builds show the PKGBUILD for review)"
    echo "  dump     Overwrite the lists with the packages that are installed now"
}

if ! command -v pacman >/dev/null; then
    echo "Error: pacman not found. This script is for Arch Linux." >&2
    exit 1
fi

check_lists() {
    if [[ ! -f "$PKG_LIST" || ! -f "$AUR_LIST" ]]; then
        echo "Error: package lists not found. Run '$SCRIPT_NAME dump' first." >&2
        exit 1
    fi
}

# Prints packages from the list given as $1 that are not installed.
missing_from() {
    comm -23 <(sort -u "$1") <(pacman -Qq | sort -u)
}

case "$1" in
    status)
        check_lists
        echo "Missing (listed, not installed):"
        missing_from "$PKG_LIST"
        missing_from "$AUR_LIST"
        echo "\nNot listed (explicitly installed, not in the lists):"
        comm -13 <(sort -u "$PKG_LIST" "$AUR_LIST") <(pacman -Qqe | sort -u)
        ;;
    install)
        check_lists
        missing_pkgs=("${(@f)$(missing_from "$PKG_LIST")}")
        missing_aur=("${(@f)$(missing_from "$AUR_LIST")}")
        if [[ -n "${missing_pkgs[1]}" ]]; then
            sudo pacman -S --needed "${missing_pkgs[@]}"
        fi
        if [[ -n "${missing_aur[1]}" ]]; then
            paru -S --needed --aur "${missing_aur[@]}"
        fi
        ;;
    dump)
        mkdir -p "${PKG_LIST:h}"
        umask 077
        pacman -Qqen > "$PKG_LIST"
        pacman -Qqem > "$AUR_LIST"
        echo "Wrote $(wc -l < "$PKG_LIST") official and $(wc -l < "$AUR_LIST") AUR packages."
        ;;
    *)
        usage
        exit 1
        ;;
esac
