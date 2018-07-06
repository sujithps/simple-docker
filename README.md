####Build image 

- Start minikube
  ``` minikube start ```

  ``` eval $(minikube docker-env) ```

- Make docker image descriptor file

  Example: 

    ```
	FROM openjdk:alpine

	WORKDIR /app
	add "$PWD/build/libs/simple-rest-0.0.1-SNAPSHOT.jar" /app/simple-rest.jar

	ENTRYPOINT ["java","-jar","simple-rest.jar"]

```

In this,  'FROM' describes the parent image (JRE to run the java application)

And then the steps to copy the executable jar file from the given context to the container.


- Execute the command to create image
   ``` docker image build -f Docker.simple_rest --tag simple-rest:1.0  ../simple-rest  ```

- Run ``` docker images ``` to get the list of images



- Create deployment and service


   -- create simple-rest-service.yaml and add the following

   apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  labels:
    app: simple-rest
  name: simple-rest-deployment
spec:
  replicas: 2
  template:
    metadata:
      labels:
        app: simple-rest
    spec:
      containers:
        - image: simple-rest:1.0
          imagePullPolicy: IfNotPresent
          name: simple-rest
          ports:
          - containerPort: 8080

---

apiVersion: v1
kind: Service
metadata:
  labels:
    app: simple-rest-service
  name: simple-rest-service
spec:
  type: NodePort
  ports:
  - port: 8080
    nodePort: 30092
    targetPort: 8080
  selector:
    app: simple-rest





- create deployment and service
  
``` kubectl apply  -f simple-rest-service.yaml ```


- get object details

  ``` kubectl get service ```
  ``` kubectl get deployments ```
  ``` kubectl get pods ```
  

