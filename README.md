# sortalon.co

This is the code that runs my personal site. It uses the
[Yesod](http://www.yesodweb.com/page/quickstart) framework using the default
site template, builds with
[Stack](http://docs.haskellstack.org/en/stable/README/), and deploys Docker.

## Development

Stack is the build tool that automates most of the building commands you need:
```
$ stack build
$ stack test
$ stack ghci
$ stack exec -- $COMMAND
```
These are all quite useful, and do what you'd expect. The latter two perform
their respective tasks using the dependencies declared in the cabal file. The
tool is also well-documented:
```
$ stack --help
```

Yesod has a convenient development mode that automatically recompiles the code
when you make changes to it. I haven't yet been able to get this working in the
Dockerized container, so you have to tell Stack to run it directly on your
machine:
```
$ stack --no-docker exec -- yesod devel
```
> Note: This will likely require rebuilding all of the app's dependencies,
> since the Docker container seems to keep a separate cache of built artifacts.

## Deployment

TBD. I'm working on making a Kubernetes configuration and setting up GCmptE &
GCntrE accounts.
