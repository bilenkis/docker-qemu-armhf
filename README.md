## Building
To build your docker image run:
1. Download fresh code with `git pull` in **opencv/opencv** and **opencv/opencv_contrib** directory
2. Run build command `docker build -t opencv-armhf:3.1 .`
3. Before take photo you need to do:
    - `pi@raspberry:~# echo -e "start_x=1\ngpu_mem=128\n" >> /boot/config.txt`
    - `pi@raspberry:~# echo "bcm2835_v4l2" >> /etc/modules`

## Troubleshooting
You can receive error during build process:
```
error="open memory.oom_control: no such file or directory"
```
Same error with cgroups was described in the https://github.com/docker/docker/issues/16256 .
To avoid this trouble run docker daemon with option:
``` 
--exec-opt native.cgroupdriver=cgroupfs
```
