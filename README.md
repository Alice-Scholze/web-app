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

### Setting cluster with hpa
- Set your deploymnet, service and hpa with:
```
kubectl apply -f manifests/deployment.yaml
kubectl apply -f manifests/service.yaml
kubectl apply -f manifests/hpa.yaml
```

### Setting cluster without hpa
- Set your deploymnet, service:
```
kubectl apply -f manifests/phpa-deployment.yaml
kubectl apply -f manifests/phpa-service.yaml
```

### Helpful commands

- Get deployment
```
kubectl get deployments
```

- Remove deployment
```
kubectl delete deployment web-app-deployment
```

- Get services
```
kubectl get services
```

- Remove services
```
kubectl delete service web-app-service

```

- Get hpa
```
kubectl get hpa
```

- Remove hpa
```
kubectl delete hpa cpu

```

- Update replicas number
```
kubectl scale deployment.v1.apps/phpa-web-app-deployment --replicas=3
kubectl --namespace monitor scale deployment.v1.apps/metrics-prometheus-server --replicas=1
```

- Get deploy data
```
kubectl get deploy
```

### Install prometheus

- Install heml
```
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
```

- Add prometheus
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://charts.helm.sh/stable
helm repo update
```

- Create namespace
```
kubectl create ns monitor
```

- Add chart
```
# You can change 'metrics' name that one you want
helm install metrics prometheus-community/prometheus --namespace monitor
helm install metrics prometheus-community/prometheus --namespace monitor --set server.service.type=LoadBalancer
```

- Port Foward
```
export POD_NAME=$(kubectl get pods --namespace monitor -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace monitor port-forward $POD_NAME 9090
```

- Add aplication metrics to prometheus
```
# Go to your prometheus-server
kubectl --namespace monitor edit cm metrics-prometheus-server

# Edit your jobs to include application
- job_name: batata
  static_configs:
  - targets:
    - phpa-web-app-service.default.svc.cluster.local:3000
  bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
```

- Remove chart
```
helm uninstall metrics --namespace monitor
helm uninstall my-release --namespace monitor
```

- Remove all from namespane
```
kubectl delete all --all -n monitor
```

- Get the Prometheus server URL by running these commands in the same shell:
```
export POD_NAME=$(kubectl get pods --namespace monitor -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace monitor port-forward $POD_NAME 9090
```

- Get the PushGateway URL by running these commands in the same shell:
```
export POD_NAME=$(kubectl get pods --namespace monitor -l "app=prometheus,component=pushgateway" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace monitor port-forward $POD_NAME 9091
```

- List services by monitor namespace
```
kubectl --namespace monitor get svc
```

## Grafana
```
kubectl create -f manifests/grafana-datasource-config.yaml
```

```
kubectl get configmap
```

```
kubectl create -f manifests/grafana-deployment.yaml
```

```
kubectl create -f manifests/grafana-service.yaml 
```

## Endpoints

