# Developer Documentation

## Setting the environment 
* Prerequisites: Install Docker, Docker Compose, Make, and Git on your host system.

* Configuration: Create a .env file by duplicating the provided .env.example template and populating it with your local environment variables.

* Secrets: Define sensitive credentials locally within the .env file, ensuring it remains excluded from version control with .gitignore.

## Launch Project 
* Execute 'make build' and then 'make up' or simple 'make'

## Manage containers
* Use make stop or make down to halt service execution, and make clean or make fclean to systematically remove containers, images, volumes, and cached data.

## Data Storage
Data Storage and Persistence: The project persists data by mapping internal container directories to host-level volumes defined in docker-compose.yml, typically located in the /home/user/data directory as required by the 42 Inception project.