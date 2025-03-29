#!/bin/sh

# This command uses `ask` command (https://github.com/DavidValin/ai-ask)
# and sox to create an interactive voice chat with ollama from terminal.
#
# https://www.github.com/DavidValin/ai-ttalk

wait_to_record() {
  while true; do
    PART=$(get_prompt_from_speech | tr '[:upper:]' '[:lower:]' | tr -d ' \n\t.,')
    # read -rsp $'\n# \n' -n1
    echo "'$PART'"
    if [ "$PART" = "heylisten" ]; then
      echo "ok"
      kill -9 $SPINNER_PID 2>/dev/null
      callback
      spinner &
      SPINNER_PID=$!
      trap "kill $SPINNER_PID" EXIT
    fi
  done
}

spinner() {
  while true; do
    for i in '⠋' '⠙' '⠹' '⠽' '⠾' '⠿'; do
      printf "\r$i "
      sleep 0.2
    done
  done
}

get_prompt_from_speech() {
  HOME_DIR=$(echo $HOME)
  PROMPT_TEXT=$(rec -q -V1 -r 16000 -b 16 -t wav - silence 1 2 0.1% 1 00:00:02 1% | whisper-cli -m $HOME_DIR/.whisper-models/ggml-large-v3-q5_0.bin -np -nt -f - | tr -d '\n')
  echo $PROMPT_TEXT
}

callback() {
  PROMPT_TEXT="$(get_prompt_from_speech)"
  printf "%s" "$PROMPT_TEXT"
  ask "$PROMPT_TEXT"
}

echo "\nLet's talk. Say 'hey, listen' to start recording"
echo "It will stop on 2 second silence:"
echo "---------------------------------------"

spinner &
SPINNER_PID=$!
trap "kill $SPINNER_PID" EXIT
wait_to_record
