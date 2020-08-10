# Make a X authentication file with proper permission
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

# Run(pull, creat, start, attach) docker
# option --user: You must use same user name in Dockerfile(ENV USERNAME yourUserName)
docker run -it \
        --rm \
	--gpus all \
        --volume=$XSOCK:$XSOCK:rw \
        --volume=$XAUTH:$XAUTH:rw \
	--volume=$HOME/ws/dataset:/home/user/dataset:rw \
	--volume=$HOME/ws/docker_ws/dexnet16-cudagl-test:/home/user/ws:rw \
        --env="XAUTHORITY=${XAUTH}" \
        --env="DISPLAY" \
        --user="user" \
	--name dexnet16-cudagl-test \
    ssw0536/dexnet-cudagl10.1-ubuntu16.04:init
