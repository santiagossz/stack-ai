# Stack AI

## How to deploy

1. Create a .env file
    ```
    cp .env.example .env
    ```
2. Fill out the following variables in the .env file. These variables are required to deploy the stack.
    - `HOST_DOMAIN`: The domain of the server to host the stack services.
        - e.g. `stack-ai.com`
    - `DEFAULT_PASS`: The default password to access the stack services. 32 digits HEX code.
        - e.g. `0123456789abcdef0123456789abcdef`
    - `S3_BUCKET`: The name of the S3 bucket to store the files shared through Whatsapp, such as images, audios, videos.
        - e.g. `stack-ai-bucket`
    - `SMTP_USERNAME`: The username for the SMTP server. Default is Gmail SMTP.
        - e.g. `admin@gmail.com`
    - `SMTP_PASSWORD`: The password for the SMTP server. Default is Gmail SMTP.
        - e.g. `password`
    - `ADMIN_EMAIL`: The email of the stack admin user. It can be either the same as `SMTP_USERNAME` or a different email.
        - e.g. `admin@gmail.com`
    - `GENERIC_TIMEZONE`: The default timezone of N8N.
        - e.g. `America/Bogota`
3. Fill out the following variables to configure the stack services subdomains. Combine them with the **HOST_DOMAIN** variable to get the full domain. For example, if **HOST_DOMAIN** is `stack-ai.com` and **N8N_SUBDOMAIN** is `n8n-prod`, the full domain will be `https://n8n-prod.stack-ai.com`.
    - `PORTAINER_SUBDOMAIN`: It will be used to access the Portainer UI.
        - e.g. `portainer`
    - `PGADMIN_SUBDOMAIN`: It will be used to access the PGAdmin UI.
        - e.g. `pgadmin`
    - `RABBITMQ_SUBDOMAIN`: It will be used to access the RabbitMQ Management UI.
        - e.g. `rabbitmq`
    - `MINIO_SERVER_SUBDOMAIN`: It will be used to access the Minio S3 API Server.
        - e.g. `minio`
    - `MINIO_CONSOLE_SUBDOMAIN`: It will be used to access the Minio Console UI.
        - e.g. `minio-console`
    - `QDRANT_SUBDOMAIN`: It will be used to access the Vector Store Qdrant UI.
        - e.g. `qdrant`
    - `TYPEBOT_UI_SUBDOMAIN`: It will be used to access the Typebot UI.
        - e.g. `typebot-ui`
    - `TYPEBOT_API_SUBDOMAIN`: It will be used to access the Typebot API service.
        - e.g. `typebot-api`
    - `N8N_SUBDOMAIN`: It will be used to access the N8N service.
        - e.g. `n8n`
    - `EVOLUTION_SUBDOMAIN`: It will be used to access the Evolution service.
        - e.g. `evolution`
    - `CHATWOOT_SUBDOMAIN`: It will be used to access the Chatwoot service.
        - e.g. `chatwoot`
4. The rest of the variables in the .env file are optional. You can always change them. But with the default values, the stack will work.
5. Run the following command to deploy the stack.
    ```
    source deploy_stack.sh
    ```
5. Run the following command to delete the stack.
    ```
    source delete_stack.sh
    ```
