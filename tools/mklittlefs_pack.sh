#!/usr/bin/env bash
set -euo pipefail

MKFS="${MKFS:-$HOME/sources/mklittlefs/mklittlefs}"

usage() {
    cat <<'EOF'
Usage: mklittlefs_pack.sh -s <size> [-b <blocksize>] [-p <pagesize>] -o <image_file> <src_path>=<dest_path> [...]

Pack files/directories into a littlefs image at arbitrary paths.

Each argument is a mapping:  <src_path>=<dest_path>
  <src_path>   File or directory on the host
  <dest_path>  Destination path inside the littlefs image (leading / optional)

  If src is a file, it is placed exactly at dest_path.
  If src is a directory, its entire contents are placed under dest_path
  preserving the relative tree structure.

Examples:
  # Single files at arbitrary paths
  mklittlefs_pack.sh -s 1M -o romfs.img \
    ~/file1.zip=/roms/duke3d/file1.zip

  # Whole directory tree
  mklittlefs_pack.sh -s 4M -o romfs.img \
    ~/my_roms/=/roms/

  # Mix of files and directories
  mklittlefs_pack.sh -s 4M -o romfs.img \
    ~/my_roms/=/roms/ \
    ~/config.json=/system/config.json

Options:
  -s <size>         Image size in bytes (required; supports K/M/G suffixes)
  -b <blocksize>    Block size (default: 4096)
  -p <pagesize>     Page size (default: 256)
  -o <image_file>   Output image file (required)
  --mklittlefs      Path to mklittlefs binary (default: $MKFS)
  -h                Show this help
EOF
    exit 0
}

SIZE=""
BLOCK=4096
PAGE=256
OUTPUT=""
MAPPINGS=()

to_bytes() {
    local val="$1"
    case "$val" in
        *K|*k) echo $(( ${val%[Kk]} * 1024 )) ;;
        *M|*m) echo $(( ${val%[Mm]} * 1024 * 1024 )) ;;
        *G|*g) echo $(( ${val%[Gg]} * 1024 * 1024 * 1024 )) ;;
        *)     echo "$val" ;;
    esac
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -s) SIZE=$(to_bytes "$2"); shift 2 ;;
        -b) BLOCK="$2"; shift 2 ;;
        -p) PAGE="$2"; shift 2 ;;
        -o) OUTPUT="$2"; shift 2 ;;
        --mklittlefs) MKFS="$2"; shift 2 ;;
        -h) usage ;;
        *)
            if [[ "$1" == *=* ]]; then
                MAPPINGS+=("$1")
            else
                echo "error: unexpected argument '$1' (expected src=dest)" >&2
                exit 1
            fi
            shift
            ;;
    esac
done

if [[ -z "$SIZE" ]]; then
    echo "error: -s <size> is required" >&2
    exit 1
fi
if [[ -z "$OUTPUT" ]]; then
    echo "error: -o <image_file> is required" >&2
    exit 1
fi
if [[ ${#MAPPINGS[@]} -eq 0 ]]; then
    echo "error: at least one src=dest mapping required" >&2
    exit 1
fi
if [[ ! -x "$MKFS" ]]; then
    echo "error: mklittlefs not found at '$MKFS'" >&2
    exit 1
fi

TMPDIR=$(mktemp -d)/
trap 'rm -rf "$TMPDIR"' EXIT

FROMFILE="$TMPDIR/filelist.txt"
>"$FROMFILE"

add_single_file() {
    local src_abs="$1"
    local dest_rel="$2"

    local parent; parent=$(dirname "$dest_rel")
    mkdir -p "$TMPDIR/$parent"
    ln -s "$src_abs" "$TMPDIR/$dest_rel"
    echo "$dest_rel" >> "$FROMFILE"
}

for map in "${MAPPINGS[@]}"; do
    src="${map%%=*}"
    dest="${map#*=}"

    # Resolve absolute source path
    src_abs=$(readlink -f "$src")

    if [[ -f "$src_abs" ]]; then
        # Single file — place exactly at dest
        dest_rel="${dest#/}"
        add_single_file "$src_abs" "$dest_rel"

    elif [[ -d "$src_abs" ]]; then
        # Directory — walk recursively, map contents into dest/
        dest_rel="${dest#/}"
        # Ensure dest_rel ends with / so paths compose cleanly
        [[ "$dest_rel" != */ ]] && dest_rel="$dest_rel/"

        while IFS= read -r -d '' f; do
            rel="${f#$src_abs/}"
            # Skip directories — mklittlefs creates them implicitly via addFile
            [[ -d "$f" ]] && continue
            add_single_file "$f" "${dest_rel}${rel}"
        done < <(find "$src_abs" -mindepth 1 -print0)

    else
        echo "warning: '$src' is neither a file nor a directory, skipping" >&2
    fi
done

echo "=== Generating littlefs image ==="
echo "  size:       $SIZE"
echo "  block:      $BLOCK"
echo "  page:       $PAGE"
echo "  output:     $OUTPUT"
echo "  files:"
while IFS= read -r line; do
    echo "    $line"
done < "$FROMFILE"

"$MKFS" -c "$TMPDIR" -T "$FROMFILE" \
    -b "$BLOCK" -p "$PAGE" -s "$SIZE" \
    -d 5 \
    "$OUTPUT"

echo "=== Done: $OUTPUT ==="
