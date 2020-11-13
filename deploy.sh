docker build -t jbsulli/multi-docker-client:latest -t jbsulli/multi-docker-client:$SHA -f ./client/Dockerfile ./client
docker build -t jbsulli/multi-docker-api:latest -t jbsulli/multi-docker-api:$SHA -f ./api/Dockerfile ./api
docker build -t jbsulli/multi-docker-worker:latest -t jbsulli/multi-docker-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jbsulli/multi-docker-client:latest
docker push jbsulli/multi-docker-client:$SHA
docker push jbsulli/multi-docker-api:latest
docker push jbsulli/multi-docker-api:$SHA
docker push jbsulli/multi-docker-worker:latest
docker push jbsulli/multi-docker-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/api-deployment api=jbsulli/multi-docker-api:$SHA
kubectl set image deployments/client-deployment client=jbsulli/multi-docker-client:$SHA
kubectl set image deployments/worker-deployment worker=jbsulli/multi-docker-worker:$SHA
