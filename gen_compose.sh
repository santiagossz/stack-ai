#!/bin/bash

source .env

# Function to generate traefik labels
generate_traefik_labels() {
    local service_name=$1
    local domain=$2
    local port=$3
    
    cat << EOF  > temp_labels.txt
        - "traefik.enable=true"
        - "traefik.http.routers.${service_name}.rule=Host(\`${domain}\`)"
        - "traefik.http.routers.${service_name}.entrypoints=websecure"
        - "traefik.http.services.${service_name}.loadbalancer.server.port=${port}"
        - "traefik.http.routers.${service_name}.service=${service_name}"
        - "traefik.http.routers.${service_name}.tls.certresolver=letsencrypt"
EOF
    if [ "$service_name" == "chatwoot-app" ]; then
        cat << EOF  >> temp_labels.txt
        - "traefik.http.middlewares.sslheader.headers.customrequestheaders.X-Forwarded-Proto=https"
        - "traefik.http.routers.${service_name}.middlewares=sslheader"
EOF
    fi
}

# Copy template to final file
cp docker-compose.tmp.yml docker-compose.yml

services=("portainer" "pgadmin" "rabbitmq" "minio-console" "minio" "qdrant" "typebot-ui" "typebot-api" "n8n" "chatwoot-app" "evolution")
domains=($PORTAINER_DOMAIN $PGADMIN_DOMAIN $RABBITMQ_DOMAIN $MINIO_CONSOLE_DOMAIN $MINIO_SERVER_DOMAIN $QDRANT_DOMAIN $TYPEBOT_UI_DOMAIN $TYPEBOT_API_DOMAIN $N8N_DOMAIN $CHATWOOT_DOMAIN $EVOLUTION_DOMAIN)
ports=($PORTAINER_PORT $PGADMIN_PORT $RABBITMQ_MANAGEMENT_PORT $MINIO_CONSOLE_PORT $MINIO_SERVER_PORT $QDRANT_PORT $TYPEBOT_PORT $TYPEBOT_PORT $N8N_PORT $CHATWOOT_PORT $EVOLUTION_PORT)

placeholders="TRAEFIK_LABELS_PLACEHOLDER"

for i in "${!services[@]}"; do
    service=${services[$i]}
    domain=${domains[$i]}
    port=${ports[$i]}
    labels=$(generate_traefik_labels $service $domain $port)
    sed -i "/${placeholders}_${service}/r temp_labels.txt" docker-compose.yml
    sed -i "/${placeholders}_${service}/d" docker-compose.yml
done

rm temp_labels.txt

echo "Generated docker-compose.yml"