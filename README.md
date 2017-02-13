# Usage

```sh
docker run -it \
           -v /tmp/.X11-unix \
           -e UID=$(id -u) \
           -e GID=$(id -g) \
           -e DISPLAY=$DISPLAY \
           -v $XAUTHORITY:/home/ubuntu/.Xauthority \
           --net=host \
           --privileged \
           vmlellis/wine \
           wine "C:\windows\system32\notepad.exe"
```
