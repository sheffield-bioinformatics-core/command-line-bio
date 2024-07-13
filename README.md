# command-line-bio
New workshop on using command-line for Bioinformatics

## Amazon details

- ami-0f9124f7452cdb2a6
```  
ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-20211129
ami-0f9124f7452cdb2a6
```

-`t2.large` 2vCPU 8Gb memory
- Storage - `Volume 1 (Template and AMI Root)` **13Gb**
- Advanced Data (User data)
- Default security group


```
#!/bin/bash

sudo apt-get update
sudo apt-get install -y docker.io
sudo service docker start
sudo usermod -aG docker $username
sudo docker pull sheffieldbioinformatics/unix-training
docker run -v --rm -d -p 5901:5901 -p 6901:6901 --privileged sheffieldbioinformatics/unix-training
```

