# Overview

Example webhook that can receive `repository` events and relay the headers and payload to an Actions workflow using `repository_dispatch`.

This uses [docker-webhook](https://github.com/almir/docker-webhook). 


## Build the Image

```
docker image build --rm -t repository-dispatch-webhook . 
```

## Run the Receiver

Set the following environment variables:

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

If you're running this locally, you can expose this publicly via [ngrok](https://ngrok.com/) or [localtunnel](https://theboroer.github.io/localtunnel-www/).

### Receiver Environment Variables
| Environment Variable | Description |
| -------------------- | ----------- |
| WEBHOOK_SECRET | The secret the receiver should use to evaluate the request. Needs to be the same as what is configured in your GitHub webhook settings. |
| GH_TOKEN | [GitHub Personal Access Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) used to make the call to the GitHub REST API [repository `/dispatches` endpoint](https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#create-a-repository-dispatch-event). |
| OWNER | The owner of the repo to send the event to |
| REPO | The repo to send the event to |
| EVENT_TYPE | The [event type](https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#create-a-repository-dispatch-event) the Actions workflow is expecting |

## GitHub Webhook Configuration

| Setting | Value |
| -------------------- | ----------- |
|Payload URL|{RECEIVER_ADDRESS}/hooks/repository-dispatch
|Content Type| application/json|
|Secret|Same value as the `WEBHOOK_SECRET` environment variable above|
