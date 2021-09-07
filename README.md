# web app

This app is just to be used by tests in kubernetes context.

## Dependencies
- cgloud
- kubectl
- docker
- docker-compose
- node

## Run
- Verify if you have correct logins to gcloud, docker hub
- Change [manifests/deployment.yaml](https://github.com/Alice-Scholze/web-app/blob/27649fc418f5b140984678765df04f527bc4b4da/manifests/deployment.yaml#L18) to your docker image
- Verify if you have a context kubernetes configured with `$ kubectl config get-contexts` (case you dn't have, can follow the tutorial to create one https://cloud.google.com/kubernetes-engine/docs/tutorials/hello-app#console)
- Set your deploymnet, service and hpa with:
```
kubectl apply -f manifests/deployment.yaml
kubectl apply -f manifests/service.yaml
kubectl apply -f manifests/hpa.yaml
```

