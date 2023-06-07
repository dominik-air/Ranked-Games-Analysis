#!/bin/sh

docker volume create --driver local -o o=bind -o type=none -o device=$(pwd)/. ranked_games_volume

docker pull iszagh/cmdstan_python:1

container_id=$(docker run -ti -d --name ranked_games_dev -v ranked_games_volume:/home iszagh/cmdstan_python:1)

docker exec $container_id pip install -r requirements.txt
