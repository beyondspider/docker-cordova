# docker cordova

## build
```bash
docker build -t beyondspider/cordova:latest .
```

## start
```bash
docker run -u root -d \
    -p 10022:22 \
    -p 18080:8080 \
    --name cordova \
    -v ~/.docker/jenkins_home:/var/jenkins_home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    beyondspider/cordova:latest
```

## ssh
```bash
ssh root@127.0.0.1 -p 10022
```

## push
```bash
docker push beyondspider/cordova:latest
```