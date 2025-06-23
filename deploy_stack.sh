if [ ! -f acme.json ]; then
   touch acme.json && chmod 600 acme.json
fi

source gen_compose.sh

echo "Deploying AI Stack"

if [ -z "$(docker network ls -q -f name=traefik)" ]; then
    docker network create traefik
fi

if [ -z "$(docker network ls -q -f name=internal)" ]; then
    docker network create internal
fi

docker compose up -d

if [ -z "$(docker ps -q -f name=chatwoot-app)" ]; then
    docker compose run --rm chatwoot-app bundle exec rails db:chatwoot_prepare
fi

docker compose --profile app up -d