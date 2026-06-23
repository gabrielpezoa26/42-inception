# User Documentation

## Services
The stack runs three services:
- **NGINX** — the only entry point, serves the site over HTTPS on port 443.
- **WordPress** — the website, running via PHP-FPM behind NGINX.
- **MariaDB** — the database used by WordPress.

## Start and Stop

```sh
make        # build and start everything
make down   # stop and remove containers
make clean  # stop, remove containers and delete data volumes
```

## Accessing the Site

| What | URL |
|---|---|
| Website | https://gcesar-n.42.fr |
| WordPress admin panel | https://gcesar-n.42.fr/wp-admin |

## Credentials

All credentials are stored as files inside `.env`.

Do not commit these files to Git.

## Checking Services

```sh
docker ps                          # list running containers
docker logs <container_name>       # view logs for a specific service
docker exec -it <container> bash   # open a shell inside a container
```

All three containers (nginx, wordpress, mariadb) should show status 'Up'.