# rinf-bench-cloud

```bash
sudo docker pull palecsandru/rinf-bench-cloud

sudo docker run -dit \
    -p 2500:80 \
    -p 2501:5000 \
    -p 2502:8099 \
    -p 2503:8080 \
    -p 2504:7777 \
    -p 2505:3306 \
    --restart=always \
    --name aibenchcloud01 \
    -v /extrastorage01/aibenchcloud01:/dataroot \
    palecsandru/rinf-bench-cloud
    
sudo docker run -dit \
    -p 2600:80 \
    -p 2601:5000 \
    -p 2602:8099 \
    -p 2603:8080 \
    -p 2604:7777 \
    -p 2605:3306 \
    --restart=always \
    --name commbenchcloud01 \
    -v /extrastorage01/commbenchcloud01:/dataroot \
    palecsandru/rinf-bench-cloud

sudo docker ps -a
```
where:
  * `80` - 3rd party precompiled data storage port
  * `5000` - Docker artifacts registry port
  * `8099` - Vagrant Cloud artifacts registry port
  * `8080` - Git port
  * `7777` - Docker artifact registry UI port
  * `3306` - MariaDB server port
