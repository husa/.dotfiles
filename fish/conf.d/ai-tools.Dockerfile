FROM node:24

RUN apt-get update \
  && apt-get install -y --no-install-recommends git sudo neovim ripgrep \
  && rm -rf /var/lib/apt/lists/*

RUN passwd -d node && adduser node sudo

RUN npm i -g @openai/codex@latest @github/copilot@latest

USER node
RUN curl https://cursor.com/install -fsS | bash
ENV PATH="/home/node/.local/bin:${PATH}"

WORKDIR /home/node/app
