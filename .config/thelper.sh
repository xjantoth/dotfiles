#!/bin/bash

tmux new-session -s "mac" -n work -d

for i in  $(ls -d */ | nl -s:); do
  wdir=${i##*:}
  DIR=${wdir%/*}
  tmux new-window -t "mac:${i%:*}" -n "${DIR}" -c "${DIR}";
  tmux split-window -t "mac:${i%:*}" -v -c "#{pane_current_path}" -l '18%';
done
