# Docker file for IDS Script


# Docker Usage 
Save the Dockerfile.
You may need to run as `sudo`
Build the Docker image by running the following command in the terminal or command prompt, assuming you are in the same directory as the Dockerfile:
```
$ docker build -t pcap-script .
```
This command will build a Docker image named "pcap-script" using the current directory as the build context. Make sure you have Docker installed and running on your machine before executing this command.

Once the image is built, you can run it as a Docker container using the following command:
```
$ docker run --net=host pcap-script
```
