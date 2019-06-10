# sortalon.co

This is the code that runs my personal site. It uses the
[Yesod](http://www.yesodweb.com/page/quickstart) framework using the default
site template, builds with
[Stack](http://docs.haskellstack.org/en/stable/README/), and deploys a Docker container
on Google Cloud Run.

## Development

Stack is the build tool that automates most of the building commands you need:
```bash
$ stack build
$ stack test
$ stack ghci
$ stack exec -- $COMMAND
```
These are all quite useful, and do what you'd expect. The latter two perform
their respective tasks using the dependencies declared in the cabal file. The
tool is also well-documented:
```bash
$ stack --help
```

Yesod has a convenient development mode that automatically recompiles the code
when you make changes to it. I haven't yet been able to get this working in the
Dockerized container, so you have to tell Stack to run it directly on your
machine:
```bash
$ stack --no-docker exec -- yesod devel
```
> Note: This will likely require rebuilding all of the app's dependencies,
> since the Docker container seems to keep a separate cache of built artifacts.

## Deployment

I did all my work from OS X, so I assume that environment.

Ensure you have Docker set up:
```bash
$ docker-machine ls
NAME      ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER    ERRORS
default   -        virtualbox   Running   tcp://192.168.99.100:2376           v1.10.3
$ docker-machine start default # if the VM isn't running.
$ eval $(docker-machine env default) # set up ENV for docker CLI
$ docker ps # just check things are set up right
CONTAINER ID        IMAGE                   COMMAND                  CREATED             STATUS              PORTS               NAMES
```

Build a Docker image:
```bash
$ stack image container
```

Run the image:
```bash
$ docker run sortalongo/sortalonco-webserver
```

Make sure it works:
```bash
$ docker exec `docker ps --format="{{.ID}}" -l` curl http://localhost:3000/
```

To keep the image for posterity:
```bash
$ docker tag sortalongo/sortalonco-webserver sortalongo/sortalonco-webserver:VERSION
```

Once that's done, we need to get the image to Google Cloud. I'll omit details
specific to my setup. Setup is pretty straightforward. Just follow the standard
flow for a Google Container Engine cluster and Google Container Repository. By
the end, you'll have the `gcloud` and `kubectl` tools set up to talk to your
G.E accounts & projects.

1. Push the image to GCR (make sure you ran `gcloud auth configure-docker`):
  ```bash
  $ docker tag sortalongo/sortalonco-webserver us.gcr.io/PROJECT/webserver:VERSION
  $ docker push us.gcr.io/PROJECT/webserver:VERSION
  ```
2. Create a service in the Cloud Run UI using the pushed image.

(If you're wondering why this README is so basic, it's because it used to detail deployment
using Kubernetes. Cloud Run is way simpler, but the doc was already written, so I just
trimmed it down)
