# rinf-bench-cloud

```bash
sudo docker pull palecsandru/rinf-bench-cloud

sudo docker run -dit \
    -p 2500:80 \    # Artifact storage
    -p 2501:5000 \  # Docker registry
    -p 2502:8099 \  # Vagrant Cloud Registry
    -p 2503:8080 \  # Git<!--
    -p 137:137 \    # SAMBA
    -p 138:138 \    # SAMBA
    -p 139:139 \    # SAMBA
    -p 445:445 \    # SAMBA-->
    --restart=always \
    --name aibenchcloud01 \
    -v /extrastorage01/aibenchcloud01:/dataroot \
    palecsandru/rinf-bench-cloud
    
sudo docker run -dit \
    -p 2600:80 \    # Artifact storage
    -p 2601:5000 \  # Docker registry
    -p 2602:8099 \  # Vagrant Cloud Registry
    -p 2603:8080 \  # Git<!--
    -p 137:137 \    # SAMBA
    -p 138:138 \    # SAMBA
    -p 139:139 \    # SAMBA
    -p 445:445 \    # SAMBA-->
    --restart=always \
    --name commbenchcloud01 \
    -v /extrastorage01/commbenchcloud01:/dataroot \
    palecsandru/rinf-bench-cloud

sudo docker ps -a
```
