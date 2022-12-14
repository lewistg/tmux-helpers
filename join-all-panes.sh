#!/usr/bin/env bash
#
# Moves all of the session's panes into a single window.

tmux list-windows | while read -r line; do
    read -r window_index num_panes <<<$(echo "$line" | sed 's/^\([0-9]\+\): \S\+ (\([0-9]\+\) panes).*/\1 \2/g')
    let pane_index=0
    while [[ $pane_index -lt $num_panes ]]; do
        tmux join-pane -s "$window_index.$pane_index"
        pane_index=$((pane_index + 1))
    done
done
tmux select-layout even-vertical
