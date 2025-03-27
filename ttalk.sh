#!/bin/sh

# This command uses `ask` command (https://github.com/DavidValin/ai-ask)
# and sox to create an interactive voice chat with ollama from terminal.
#
# https://www.github.com/DavidValin/ai-ttalk

wait_and_record() {
  while true; do
    read -rsp $'\n# \n' -n1
    execute_command
  done
}

execute_command() {
  echo "..."
  HOME_DIR=$(echo $HOME)
  PROMPT_TEXT=$(rec -q -V1 -r 16000 -b 16 -t wav - silence 1 0.50 0.1% 1 00:00:02 1% | whisper-cli -m $HOME_DIR/.whisper-models/ggml-large-v3-q5_0.bin -np -nt -f - | tr -d '\n')
  echo $PROMPT_TEXT
  ask $PROMPT_TEXT
}

# Iniciar el script
echo "\nLet's talk. Press any hey to record."
echo "It will stop on 2 second silence:"
echo "---------------------------------------"
wait_and_record
