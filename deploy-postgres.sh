eval $(minikube docker-env)

kubectl apply -f postgres-service.yaml

sleep 5

kubectl exec -it "$(kubectl get po | grep 'postgres-[-a-z0-9]*' -o)" -- psql -c 'create database simple'
