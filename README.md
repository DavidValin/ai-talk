# ai-talk

* Terminal `ttalk` command that initializes a voice one-time prompt with ollama via `ask` command.
* By David Valin : https://www.davidvalin.com/dev

![ai talk screenshot](https://github.com/DavidValin/ai-talk/raw/main/ai-talk-schema.jpg)

### Dependencies:

#### Install ai-ask

README.md `https://github.com/DavidValin/ai-ask`

#### Install Record + Transcription deps

* `brew install sox`
* `brew install whisper-cpp`

#### Install software

* `make`: this will download whispper large model and setup the `ttalk` command

### Commands:

* `ttalk` Starts the program

Say 'hey, listen' to start recording. It will stop on 2 second silence.
This audio will be transcribed to text and prompted to ollama via `ask`.
See ttalk.sh for details and customizations.
