cd ~/Documents/work
tmux new-session -s "mac" -n work -d

for i in  $(ls -d */ | nl -s:); do 
  tmux new-window -t "mac:${i%:*}" -n "${i##*:}" -c ${i##*:};
  tmux split-window -t "mac:${i%:*}" -v -c "#{pane_current_path}" -l '20%';
done
