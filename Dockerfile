FROM node

MAINTAINER Tadeusz Łazurski <tadeusz@lazurski.pl>

RUN npm i -g forever

RUN mkdir /app
ADD .     /app
WORKDIR   /app

RUN make build

EXPOSE 3210

CMD ["forever", "lib/app.js"]
