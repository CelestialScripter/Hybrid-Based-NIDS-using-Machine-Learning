# Docker  file for Python Script trained model
Make sure you have Docker installed and running on your machine before following the steps below. 
# Docker Usage 
Save the Dockerfile.
You may need to run as `sudo`
Open a terminal or command prompt and navigate to the directory containing the Dockerfile and the script.
Build the Docker image by running the following command:
```
$ docker build -t random-forest-predict .

```
This command builds the Docker image and tags it with the name random-forest-predict.
After the image is successfully built, you can run a container based on the image using the following command:
```
$ docker run random-forest-predict

```
This will execute the script inside the Docker container.
