FROM node:24

RUN apt-get update \
  && apt-get install -y --no-install-recommends git sudo neovim curl wget jq ripgrep fd-find \
  && rm -rf /var/lib/apt/lists/*

RUN passwd -d node && adduser node sudo

RUN npm i -g @openai/codex@latest

USER node

RUN curl -fsSL https://gh.io/copilot-install | bash && \
  curl -fsSL https://cursor.com/install | bash && \
  curl -fsSL https://claude.ai/install.sh | bash

ENV PATH="/home/node/.local/bin:${PATH}"
ENV COLORTERM=truecolor

WORKDIR /home/node/app
