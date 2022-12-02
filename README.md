# Dumbcron

A minimal http service which runs http GET requests periodically

It's a docker image that's designed for easily triggering http endpoints in a portable and reliable way

## Features

- Runs an HTTP GET request periodically
- Lightweight, uses less than 3mb of memory. The docker image is less than 30mb
- Unlike cron, has actually usable logs and error handling
- Dead simple to use and integrate

## Usage

Sample standalone usage:

`docker run  --env TARGET_URL=https://httpbin.org/ip lukmyslinski/dumbcron`

Output:

```sh
2022-12-02T21:04:05 [INFO] - Calling https://httpbin.org/ip
2022-12-02T21:04:06 [INFO] - 200 OK, "{\n  \"origin\": \"83.21.145.90\"\n}\n"
2022-12-02T21:04:06 [INFO] - Sleeping for 5s seconds
2022-12-02T21:04:11 [INFO] - Calling https://httpbin.org/ip
2022-12-02T21:04:12 [INFO] - 200 OK, "{\n  \"origin\": \"83.21.145.90\"\n}\n"
2022-12-02T21:04:12 [INFO] - Sleeping for 5s seconds
```


### Parameters

`TARGET_URL` - the HTTP GET request to make. No params are supported

`SLEEP_DURATION` - The amount of time to pause between requests in seconds. Optional, defaults to 5

`INITIAL_DELAY` - The initial delay in seconds when first starting up. Optional, defaults to 0


### Docker-compose usage

Sample `docker-compose.yml`: 

```yml
version: "3.2"
services:
  dumbcron:
    image: lukmyslinski/dumbcron
    environment:
      TARGET_URL: "http://your-service:3000/some-endpoint"      
      SLEEP_DURATION: 3600
      INITIAL_DELAY: 30
    restart: always
  your-service:
    image: your-service
    ports:
      - "3000:3000"
    restart: always
```

## Why

I needed to run some http requests periodically via docker-compose. All existing solutions weren't a good fit so I build this instead.

> Running cron jobs in docker is an antipattern, you should use systemd

Yes it is and I don't care - systemd takes effort and is not easily portable. This service literally uses less than 3mb of memory, I don't need this to be ran with pinpoint timestamp accuracy. As long as it runs sort of on schedule it's good enough. 