docker stop aws_az_migrate
docker rm aws_az_migrate
docker build -t aws_az_migrate .
docker run -it --name aws_az_migrate --env-file ./dev.env aws_az_migrate