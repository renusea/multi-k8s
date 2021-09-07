docker build -t renusea/multi-client:latest -t renusea/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t renusea/multi-server:latest -t renusea/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t renusea/multi-worker:latest -t renusea/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push renusea/multi-client:latest
docker push renusea/multi-server:latest
docker push renusea/multi-worker:latest

docker push renusea/multi-client:$SHA
docker push renusea/multi-server:$SHA
docker push renusea/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=renusea/multi-server:$SHA
kubectl set image deployments/client-deployment client=renusea/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=renusea/multi-worker:$SHA