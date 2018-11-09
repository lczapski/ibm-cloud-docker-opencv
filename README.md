# ibm-cloud-docker-opencv
IBM Cloud Functions Docker Image with openCV

Create and push docker image:

docker build -t lczapsk/opencv3 .
docker push lczapsk/opencv3


Run:

docker run lczapsk/opencv3

Show running:

docker ps

SSH:

docker exec -i -t da25edc9b3ab /bin/bash

Cope from and to image:

docker cp ./src da25edc9b3ab:/action/

docker cp da25edc9b3ab:/action/ ./temp
