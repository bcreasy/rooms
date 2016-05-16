FROM node:argon
MAINTAINER genetik <genetik@caffeine.nu>

RUN groupadd -r rooms && useradd -r -g rooms rooms

RUN mkdir -p /srv/rooms
WORKDIR /srv/rooms

COPY package.json /srv/rooms
RUN npm install

COPY . /srv/rooms

EXPOSE 1337

CMD [ "npm", "start" ]
