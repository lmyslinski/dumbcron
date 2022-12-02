# dumbcron
A minimal http service which runs http requests periodically

It's a docker image that's designed for running via docker-compose

### Running cron jobs in docker is an antipattern, you should use systemd

Yes it is and I don't care - systemd takes effort and is not portable. This service literally takes 2mb of memory, I don't need this to be ran with pinpoint timestamp accuracy. As long as it runs sort of on schedule it's good enough. 

## Usage

```
version: "3.2"
services:
  syncer:
    image: lukmyslinski/dumbcron
    environment:
      TARGET_URL: "http://your-service:3000/some-endpoint"      
      SLEEP_DURATION: 3600
    restart: always
  your-service:
    build: .
    image: lukmyslinski/my-service
    ports:
      - "3000:3000"
    restart: always
```


## Why

I needed to run some http requests periodically via docker-compose. All existing solutions weren't a good fit so I build this brain-dead service which does what is required:

- runs a request configured by an env var
- goes to sleep for a duration of time

And it's written in rust so it's as lightweight as possible.



