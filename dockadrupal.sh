### source dockadrupal.sh projectName 8000 8001
### $1 Project Name
### $2 HTTP Port
### $3 HTTPS Port

PROJECT_NAME=$1
PROJECT_HTTP_PORT=$2
PROJECT_HTTPS_PORT=$3

### Override config/.env environment variables. 
export PROJECT_NAME
export PROJECT_HTTP_PORT
export PROJECT_HTTPS_PORT

mkdir ${PROJECT_NAME}
cd config
docker-compose config > ../${PROJECT_NAME}/docker-compose.yaml
cd ../${PROJECT_NAME}
docker-compose build
docker-compose up -d
