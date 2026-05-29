#!/usr/bin/env bash
set -euo pipefail

readonly DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/qo"
readonly TASKS_FILE="$DATA_DIR/tasks.txt"

mkdir -p "$DATA_DIR"
touch "$TASKS_FILE"

usage() {
    cat <<'EOF'
tasq - a tiny FIFO task queue

Usage:
  tasq                Show current task
  tasq current        Show current task
  tasq add <task>     Add task to queue
  tasq done           Complete current task
  tasq list           List all tasks
  tasq clear          Remove all tasks
  tasq help           Show this help

Examples:
  tasq add "Implement OAuth flow"
  tasq
  tasq done
EOF
}

current() {
    head -n 1 "$TASKS_FILE"
}

add() {
    if [[ $# -eq 0 ]]; then
        printf 'error: missing task text\n' >&2
        exit 1
    fi

    printf '%s\n' "$*" >> "$TASKS_FILE"
    printf 'added: %s\n' "$*"
}

done_task() {
    local task

    task="$(current)"

    if [[ -z "$task" ]]; then
        printf 'queue is empty\n'
        return 0
    fi

    printf 'done: %s\n' "$task"

    local tmp
    tmp="$(mktemp)"

    tail -n +2 "$TASKS_FILE" > "$tmp"
    mv "$tmp" "$TASKS_FILE"
}

list() {
    if [[ ! -s "$TASKS_FILE" ]]; then
        printf 'queue is empty\n'
        return 0
    fi

    nl -w2 -s'. ' "$TASKS_FILE"
}

clear() {
    : > "$TASKS_FILE"
    printf 'cleared queue\n'
}

main() {
    case "${1:-current}" in
        current)
            current
            ;;
        add)
            shift
            add "$@"
            ;;
        done)
            done_task
            ;;
        list|ls)
            list
            ;;
        clear)
            clear
            ;;
        help|-h|--help)
            usage
            ;;
        *)
            printf 'unknown command: %s\n\n' "$1" >&2
            usage >&2
            exit 1
            ;;
    esac
}

main "$@"
