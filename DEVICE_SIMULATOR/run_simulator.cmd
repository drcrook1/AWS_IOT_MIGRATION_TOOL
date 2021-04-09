docker stop aws_az_device_simulator
docker rm aws_az_device_simulator
docker build -t aws_az_device_simulator .
docker run -it --name aws_az_device_simulator --env-file ./dev.env aws_az_device_simulator