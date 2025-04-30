# Allow CD to the chosen directory in LF
lfcd() {
  tmpfile=$(mktemp)
  LF_LAST_DIR_PATH="$tmpfile" command lf "$@"  # Avoid recursion by bypassing alias
  if [ -f "$tmpfile" ]; then
    dir=$(<"$tmpfile")
    rm -f "$tmpfile"
    if [ -d "$dir" ]; then
      cd "$dir"
      command -v zoxide &>/dev/null && zoxide add "$dir"
    fi
  fi
}

# Lazy Git Directory Changes
lzg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

# Postpend Render to ChatGPT
chat() {
  chatgpt "$@" | batcat --language=markdown --style=plain --paging=never
}

