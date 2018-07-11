eval $(minikube docker-env)

kubectl delete -f simple-rest-db-service.yaml


docker image build -f Docker.simple_db_rest --tag simple-db-rest:1.0 ../simple-db-rest

kubectl apply -f simple-rest-db-service.yaml
