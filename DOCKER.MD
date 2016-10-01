# DOCKER.MD

Utterly incomplete but here are some commands to get things up and running with Docker for npmsearch.com.

Build the npmsearch directory.

`docker build -t npmsearch .  `

Check out the `Dockerfile` for more info.

Now, fetch the Elasticsearch image.

`docker pull elasticsearch`

Open 3 ports...

`docker run -d -p 9200:9200 -p 9300:9300 -p 9201:9201 elasticsearch`

Now run the web client

`docker run -d -p 8080:8080 npmsearch`

If you open your browser at `http://localhost:8080` you should see the web client running.

# TODO

Unanswered questions/unknowns

1) We need to likely create a `k8s` deployment config file to run the Elasticsearch image and the webapp itself.  Likely we run this on GKE or ECS worst case (preference is GKE)
2) The commaneds in the `README.md` need to be reflective of a containerized environment.

Step 1 (how does this work in the k8s or Docker world?) 

Note: I changed the index name to `npmsearch-index` in these examples below.

```bash
# create an index
curl -XPUT http://localhost:9200/npmsearch-index
```

Step 2 (how does this work in the k8s or Docker world?)

# setup the package field mappings

`cat mappings.json | curl -v -XPOST http://localhost:9200/npmsearch-index/package/_mapping -H "Content-type: application/json" -d @-`

Step 3 (how does this work in the k8s or Docker world?)

# setup an alias to 'registry'

```bash

curl --request POST \
--data '{"actions" : [{ "add" : { "index" : "npmsearch-index", "alias" : "registry" } }]}' \
 http://localhost:9201/_aliases

curl -XPOST http://localhost:9201/_aliases -d '{"actions" : [{ "add" : { "index" : "npmsearch-index", "alias" : "registry" } }]}'

```

Step 4 (how does this work in the k8s or Docker world? and *most importantly* how do we only do this  _once_ and persist it?)

## pipe the npm registry into elasticsearch

```
npm2es --couch="https://skimdb.npmjs.com/registry" --es="http://localhost:9200/registry"

```
