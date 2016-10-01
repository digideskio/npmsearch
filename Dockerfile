# https://nodesource.com/blog/8-protips-to-start-killing-it-when-dockerizing-node-js/

FROM nodesource/nsolid:v1.4.0

MAINTAINER Joe McCann <joe@nodesource.com>

COPY package.json .  
RUN npm install --production  
COPY . . 

CMD ["node", "bin/server.js", "--es=\"http://localhost:9200/registry\""] 
