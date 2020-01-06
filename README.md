# ft_server

#create img
docker build -t img .

#run
docker run -d -p 80:80 -p 3306:3306 -p 443:443 img

#see container files
docker exec -ti ID

#stop
docker stop container id

#see running containers
docker ps

#clean
docker system prune

