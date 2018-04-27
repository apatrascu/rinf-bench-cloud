# rinf-bench-cloud

```bash
sudo docker pull palecsandru/rinf-bench-cloud

sudo docker run -dit \
    -p 2500:80 \
    -p 2501:5000 \
    -p 2502:8099 \
    -p 2503:8080 \ <!--
    -p 137:137 \
    -p 138:138 \
    -p 139:139 \
    -p 445:445 \ -->
    --restart=always \
    --name aibenchcloud01 \
    -v /extrastorage01/aibenchcloud01:/dataroot \
    palecsandru/rinf-bench-cloud
    
sudo docker run -dit \
    -p 2600:80 \
    -p 2601:5000 \
    -p 2602:8099 \
    -p 2603:8080 \ <!--
    -p 137:137 \
    -p 138:138 \
    -p 139:139 \
    -p 445:445 \ -->
    --restart=always \
    --name commbenchcloud01 \
    -v /extrastorage01/commbenchcloud01:/dataroot \
    palecsandru/rinf-bench-cloud

sudo docker ps -a
```
where:
  * `80` - Artifact storage port
  * `5000` - Docker registry port
  * `8099` - Vagrant Cloud registry port
  * `8080` - Git port
