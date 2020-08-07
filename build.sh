#!/bin/bash
DOCKER_EXEC=$(command -v docker)
COMPOSE_EXEC=$(command -v docker-compose)

echo $DOCKER_EXEC

if [ -z ${UID} ]; then
    export UID=$(id -u)
fi

if [ -z ${GID} ]; then
    export GID=$(id -g)
fi

if [ "${NO_CACHE}" == "y" ]; then
    echo "Not using cache"
    export CLEAN_BUILD="--no-cache";
fi

if [ -f "${DOCKER_EXEC}" ]; then
    docker build --force-rm ${CLEAN_BUILD} --compress --network=host --build-arg UID=${UID} --build-arg GID=${GID} -t opensuse/texlive .
else
    echo "Did not found the docker executable in $PATH";
    exit 1
fi
