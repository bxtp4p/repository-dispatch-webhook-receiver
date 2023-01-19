# Overview

Example webhook that can receive `repository` events and relay the headers and payload to an Actions workflow using `repository_dispatch`.

This uses [docker-webhook](https://github.com/almir/docker-webhook). 


## Build the image

```
docker image build --rm -t repository-dispatch-webhook . 
```

## Running

Clone and navigate to this repo directory. Set the following environment variables:

```
export WEBHOOK_SECRET=[[mysecret]]
export GH_TOKEN=[[your pat token]]
export OWNER=[[owner]]
export REPO=[[repo]]
export EVENT_TYPE=[[example]]
```

Run the following:
```
docker run -d -p 9000:9000 \
   -v $PWD/scripts:/var/scripts \
   -v $PWD/hooks:/etc/webhook \
   -e WEBHOOK_SECRET=${WEBHOOK_SECRET} \
   -e GH_TOKEN=${GH_TOKEN} \
   -e OWNER=${OWNER} \
   -e REPO=${REPO} \
   -e EVENT_TYPE=${EVENT_TYPE} \
   --name=webhook \
   repository-dispatch-webhook -verbose -hooks=/etc/webhook/hooks.json -hotreload -template
```