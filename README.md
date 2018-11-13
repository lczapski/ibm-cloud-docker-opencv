# ibm-cloud-docker-opencv
IBM Cloud Functions Docker Image with openCV

Create and push docker image:
```bash
docker build -t lczapsk/opencv3 .
docker push lczapsk/opencv3
```

Run:
```bash
docker run lczapsk/opencv3
```
Show running:
```bash
docker ps
```
SSH:
```bash
docker exec -i -t da25edc9b3ab /bin/bash
```
Cope from and to image:
```bash
docker cp ./src da25edc9b3ab:/action/

docker cp da25edc9b3ab:/action/ ./temp
```