#!/bin/bash

C=aibenchcloud001

docker stop $C
docker rm $C

#sudo rm -rf /tmp/$C
mkdir -p /tmp/$C

#docker run -dit \
#    -p 2500:80 \
#    -p 2501:5000 \
#    -p 2502:8099 \
#    -p 2503:8080 \
#    -p 2504:7777 \
#    -p 2505:3306 \
#    -p 139:139 \
#    -p 445:445 \
#    -e USE_SAMBA=True \
#    --restart=always \
#    --name $C \
#    -v /tmp/$C:/dataroot \
#    rinf-bench-cloud


docker run -dit \
    -p 2500:80 \
    -p 2501:5000 \
    -p 2502:8099 \
    -p 2503:8080 \
    -p 2504:7777 \
    -p 2505:3306 \
    -e USE_SAMBA=False \
    --restart=always \
    --name $C \
    -v /tmp/$C:/dataroot \
    rinf-bench-cloud


sleep 5

docker exec -it $C /bin/bash
