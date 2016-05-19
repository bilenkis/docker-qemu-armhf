## Building
To build your docker image run:
```
docker build -t opencv-armhf:3.1 .
```

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
