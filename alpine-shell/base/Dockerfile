FROM node:alpine as cli_builder
RUN apk add --no-cache libstdc++
RUN wget https://github.com/hyperonecom/h1-cli/archive/master.tar.gz
RUN tar xvzf master.tar.gz
WORKDIR /h1-cli-master
RUN npm install .
RUN npx pkg -c package.json -t "node12-alpine" -o "./dist/h1" "./bin/h1"
FROM alpine
LABEL maintainer="HyperOne"
WORKDIR /data
## TODO: Use binary after release 1.7.0
COPY --from=cli_builder /h1-cli-master/dist/h1 /bin/h1
RUN apk add --no-cache rsync wget nano mc vim mariadb-client openssh-sftp-server subversion postgresql-client
RUN ln -s /usr/lib/openssh/sftp-server /usr/bin/sftp-server
## TODO: Fix locale issues - https://gitlab.com/rilian-la-te/musl-locales/issues/6
