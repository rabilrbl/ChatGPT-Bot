FROM ubuntu:latest 

# Install Node via nvm
RUN apt-get update && apt-get install -y curl
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash 
ENV NVM_DIR /root/.nvm
ENV NODE_VERSION lts
RUN . $NVM_DIR/nvm.sh && nvm install $NODE_VERSION && nvm use $NODE_VERSION

# Install google chrome stable
RUN apt-get update && apt-get install -y wget gnupg2
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
RUN apt-get update && apt-get install -y google-chrome-stable

COPY . /app
WORKDIR /app

# Install app dependencies
RUN . $NVM_DIR/nvm.sh && npm install

# Run the app
CMD . $NVM_DIR/nvm.sh && npm run start
