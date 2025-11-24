FROM node:24
RUN apt update && apt install -y git sudo neovim ripgrep
RUN passwd -d node && adduser node sudo
RUN npm i -g @openai/codex@latest
USER node
WORKDIR /home/node/app
ENTRYPOINT [ "codex" ]
CMD ["--ask-for-approval", "untrusted"]

