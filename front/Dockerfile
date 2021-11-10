FROM node:16 as build-stage

# install JQ to replace config.json values
ENV JQ_VERSION=1.6

RUN wget --no-check-certificate https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64 -O /tmp/jq-linux64

RUN cp /tmp/jq-linux64 /usr/bin/jq

RUN chmod +x /usr/bin/jq

# make the 'app' folder the current working directory
WORKDIR /app

# copy project files and folders to the current working directory (i.e. 'app' folder)
COPY . .

RUN jq 'to_entries | map_values({ (.key) : ("$" + .key) }) | reduce .[] as $item ({}; . + $item)' ./src/config.json > ./src/config.tmp.json && mv ./src/config.tmp.json ./src/config.json

# install project dependencies & build app for production with minification
RUN npm install

RUN npm run build



FROM nginx:1.17 as production-stage

ENV JSFOLDER=/usr/share/nginx/html/js/app.*.js

COPY ./entrypoint.sh /usr/bin/entrypoint.sh

COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf

RUN chmod +x /usr/bin/entrypoint.sh

WORKDIR /usr/share/nginx/html

COPY --from=build-stage /app/dist .

CMD [ "entrypoint.sh" ]
