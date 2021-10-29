# theme02

## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Lints and fixes files
```
npm run lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).

Commande faite par bebert pour le docker

Tuto
https://www.middlewareinventory.com/blog/docker-vuejs/
docker build . -t front-vue

l'image est faite

docker run -it -p 8080:8080 -d --name container-vuejs frontvuejs




Master@DESKTOP-SMM7T2V MINGW64 ~/Documents/Travail/epitech/700poo-devops-19/front (master)
$ docker run -it -p 8080:8080 -d --name container-vuejs front-vue
071c248df2e19e59f9e1b9292c254d9ef6f4df6cb93a3401019fd283b16ebf4e

Master@DESKTOP-SMM7T2V MINGW64 ~/Documents/Travail/epitech/700poo-devops-19/front (master)
$ docker ps
CONTAINER ID   IMAGE       COMMAND                  CREATED          STATUS          PORTS                    NAMES
071c248df2e1   front-vue   "docker-entrypoint.s…"   16 seconds ago   Up 14 seconds   0.0.0.0:8080->8080/tcp   container-vuejs




