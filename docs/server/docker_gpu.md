### about

I need my Jellyfin container to use the GTX 650 in my server for hardware transcoding  
(debian 9, amd64)

note: once docker-compose 3.x supports `docker run --gpus`, a lot of these will change.  
use `NVIDIA_VISIBLE_DEVICES=all` for the containers you need

### commands

    $ distribution=$(. /etc/os-release; echo $ID$VERSION_ID)
    $ curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
    $ curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list >/etc/apt/sources.list.d/nvidia-docker.list
    $ apt update

### packages

- libnvidia-encode1 >= 418.20
- libcuda1
- nvidia-container-toolkit
- nvidia-container-runtime

### files 

`/etc/docker/daemon.json`

    {
        "default-runtime": "nvidia",
        "runtimes": {
            "nvidia": {
                "path": "/usr/bin/nvidia-container-runtime",
                "runtimeArgs": []
            }
        }
    }
