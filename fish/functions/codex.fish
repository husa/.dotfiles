function codex --description "OpenAI Codex in Docker"
  d run --rm -it -v $HOME/.codex:/home/node/.codex -v ./:/home/node/app codex $argv
end
