# rinf-bench-cloud

## Install

```bash
sudo docker pull palecsandru/rinf-bench-cloud
sudo docker run -dit -p 2000:80 --restart=always --name aibenchcloud01 -v /extrastorage01/aibenchcloud01:/data palecsandru/rinf-bench-cloud
sudo docker run -dit -p 2000:80 --restart=always --name commbenchcloud01 -v /extrastorage01/commbenchcloud01:/data palecsandru/rinf-bench-cloud
sudo docker ps -a
```
