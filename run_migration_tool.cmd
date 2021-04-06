docker stop aws_az_migrate
docker rm aws_az_migrate
docker build -t aws_az_migrate .
docker volume rm terraform
docker volume create --name terraform
docker run -it --name aws_az_migrate -v terraform:/mnt/tfstate aws_az_migrate