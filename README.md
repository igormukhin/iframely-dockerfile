Simple Dockerfile for Iframely
=================================

## Building the image

For building the docker image clone the project and:

```
docker build -t iframely .
```

## Running the image

```
docker run -d -p 8061:8061 --name iframely iframely
```

To test it, call the folling URL in a browser or `curl` it:

```
http://localhost:8061/iframely?uri=https://www.youtube.com/watch?v=9bZkp7q19f0
```
