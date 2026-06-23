*This project has been created as part of the 42 curriculum by gcesar-n*

## Description
Inception is a project at 42 School about setting up a small infrastructure with Nginx, Wordpress and Mariadb, each one on it's
own Docker container.

Each service has its own Dockerfile built from the penultimate stable Debian release. All sources (Dockerfiles, configs, docker-compose.yml) are inside `srcs/`.

Design choices:
- **VMs vs Docker** — Docker was chosen for being lighter and faster; it shares the host kernel instead of emulating a full machine.
- **Secrets vs Env Vars** — Secrets are used for sensitive data (passwords); unlike env vars, they aren't exposed in `docker inspect`.
- **Docker Network vs Host** — A private bridge network isolates the containers from the host; services reach each other by name.
- **Volumes vs Bind Mounts** — Bind mounts are used as required by the subject, storing data at a known path on the host.


## Instructions
Build and run the containers simply using **make**. You can also use **make build** for building the containers but not running it yet.

## Resources

https://www.youtube.com/watch?v=DQdB7wFEygo&t=477s

https://www.youtube.com/watch?v=DdoncfOdru8

* AI was used mainly for understanding Docker/Linux specific errors, helping with learning Docker commands and debugging.
