# dex-net-docker
Docker for Berkeley AUTOLAB's Dex-Net Package.
### Tested environment
Docker version: 19.03.12 \
Host PC os : ubuntu 18.04
Container os : ubuntu 16.04

---
## 1. Build image
Note that base image of this example is nvidia/cudagl:10.1-devel-ubuntu16.04, which can be found on https://hub.docker.com/r/nvidia/cudagl/.
### 1) Build image from docker file
#### 1-1) Download `Dockerfile` and `sh files`.
```bash
# make your/docker/path
mkdir dexnet-docker

wget https://raw.githubusercontent.com/ssw0536/dex-net-docker/master/docker/Dockerfile
wget https://raw.githubusercontent.com/ssw0536/dex-net-docker/master/docker/build.sh
wget https://raw.githubusercontent.com/ssw0536/dex-net-docker/master/docker/docker_run.sh
```
#### 1-2) Change `--uid` and `--gid` options in `Dockerfile`.(for using GUI)
To use GUI on the docker container, you should do some modifications to the original image by creating a user with uid and gid matching that of the host user. More details you can find on here, http://wiki.ros.org/docker/Tutorials/GUI. You can check `--uid` and `--gid` on your host PC by using bellow command on the teminal. 
```bash
id
# response
# uid=1000(you_user_name) gid=1000(you_user_name) ...
```
Then change `--uid` and `--gid` on the Dockerfile, where you can find them on `Line17-18`.
```Dockerfile
ENV USERNAME user
RUN apt-get update && \
        apt install sudo && \
        useradd -m $USERNAME && \
        echo "$USERNAME:$USERNAME" | chpasswd && \
        usermod --shell /bin/bash $USERNAME && \
        usermod -aG sudo $USERNAME && \
        echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
        chmod 0440 /etc/sudoers.d/$USERNAME && \
        # Replace 1000 with your user/group id
        usermod  --uid 1000 $USERNAME && \
        groupmod --gid 1000 $USERNAME
```

#### 1-3) Build image.
```bash
docker build -t ssw0536/dexnet-cudagl10.1-ubuntu16.04:init ./
```
### 2) Run docker container with proper mount option.
#### 2-1) Edit `docker_run.sh`
You should modify `docker_run.sh` to make proper mount option. Check the Line 13-14.
```bash
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

# Run(pull, creat, start, attach) docker
# option --user: You must use same user name in Dockerfile(ENV USERNAME yourUserName)
docker run -it \
	--gpus all \
        --volume=$XSOCK:$XSOCK:rw \
        --volume=$XAUTH:$XAUTH:rw \
	    --volume=your/dataset/path:/home/user/dataset:rw \ # volume for dex-net dataset
	    --volume=your/codbase/path:/home/user/ws:rw \ # volume for dex-net codebase
        --env="XAUTHORITY=${XAUTH}" \
        --env="DISPLAY" \
        --user="user" \
	--name dexnet16-cudagl-test \
    ssw0536/dexnet-cudagl10.1-ubuntu16.04:init
```
#### 2-2) Docker run!
```bash
source docker_run.sh
```
### 3) install dex-net codebase on the container.
In your container,
```bash
# get into workspace
cd ~/ws

# download sh file and requiements.txt
wget https://raw.githubusercontent.com/ssw0536/dex-net-docker/master/basic_requirements.txt
wget https://raw.githubusercontent.com/ssw0536/dex-net-docker/master/advanced_requirements.txt
wget https://raw.githubusercontent.com/ssw0536/dex-net-docker/master/install.sh

# install
source install.sh
```
---
### Install OpenRAVE on ubuntu16.04
# (optional, for collision checking)
# install OpenRAVE 0.9 from jeffmahler fork
```bash
git clone https://github.com/jeffmahler/openrave.git
cd openrave
```
https://scaron.info/teaching/installing-openrave-on-ubuntu-16.04.html
https://github.com/rdiankov/openrave/issues/500

```bash
sudo sh install.sh
cd ..
```


## 2. Pull image from docker hub.
Will be update soon....
