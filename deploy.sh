docker build -t elliedockeren/multi-client:latest -t elliedockeren/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t elliedockeren/multi-server:latest -t elliedockeren/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t elliedockeren/multi-worker:latest -t elliedockeren/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push elliedockeren/multi-client:latest
docker push elliedockeren/multi-server:latest
docker push elliedockeren/multi-worker:latest

docker push elliedockeren/multi-client:$SHA
docker push elliedockeren/multi-server:$SHA
docker push elliedockeren/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=elliedockeren/multi-server:$SHA
kubectl set image deployments/client-deployment client=elliedockeren/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=elliedockeren/multi-worker:$SHA
