FROM node:24

RUN apt-get update \
  && apt-get install -y --no-install-recommends git sudo neovim ripgrep \
  && rm -rf /var/lib/apt/lists/*

RUN passwd -d node && adduser node sudo

RUN npm i -g @openai/codex@latest @github/copilot@latest

USER node
WORKDIR /home/node/app
