# Docker file for IDS Script
Make sure you have Docker installed and running on your machine before following the steps below.

# Docker Usage 
Save the Dockerfile.
You may need to run as `sudo`
Build the Docker image by running the following command in the terminal or command prompt, assuming you are in the same directory as the Dockerfile:
```
$ docker build -t Python script.pcap .
```
This command will build a Docker image named "pcap-script" using the current directory as the build context. Make sure you have Docker installed and running on your machine before executing this command.

Once the image is built, you can run it as a Docker container using the following command:
```
$ docker run --net=host Python script.pcap
```
