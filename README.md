# ft_server 

UPDATE : add ARG DEBIAN_FRONTEND=noninteractive at beginning of Dockerfile, or no frontend.

create img \
docker build -t img .

run \
docker run -d -p 443:443 -p 80:80 -p 3306:3306 img

see container files \
docker exec -ti ID

stop \
docker stop container id

see running containers \
docker ps

clean \
docker system prune \
docker system prune -a

tuto ssl \
https://www.freecodecamp.org/news/how-to-get-https-working-on-your-local-development-environment-in-5-minutes-7af615770eec/

MDP phpmyadmin : newuser, password.
