# docker-wait

# What ?

A very simple alpine-based docker image embedding a very simple netcat-based shell script.

# Why ?

A lot of different wait scripts [exist already](https://hub.docker.com/search/?isAutomated=0&isOfficial=0&page=1&pullCount=0&q=wait&starCount=0), so why another one?

It appears that all of them are based on the old --link mechanisms.  
None of them handle easily the new network-based hostnames.

This one differs by providing an arbitrary host and port via command line argument.

It also handles DELAY and RETRIES via env variables.

# How ?

Imagine you use docker-compose 1.6+.  
It will by default create a network based on the current directory name (let's assume: "my_project").

> Note: docker-compose will by default create a network name "my_project_default".

Now imagine you have a "db" container that should listen on port 3306.

> Note: docker-compose will create aliases for the "db" service.
> Both "my_project_db_1" and "db" are valid.

    docker run --net my_project_default docteurklein/wait db 3306

If you want to increase the delay (10sec between each retry):

    docker run -e DELAY=10 --net my_project_default docteurklein/wait db 3306

If you want to limit to 10 retries:

    docker run -e RETRIES=10 --net my_project_default docteurklein/wait db 3306


> Note: You can combine both `DELAY` and `RETRIES`.

