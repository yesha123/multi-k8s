docker build -t yesha123/multi-client:latest -t yesha123/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yesha123/multi-server:latest -t yesha123/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yesha123/multi-worker:latest -t yesha123/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push yesha123/multi-client:latest
docker push yesha123/multi-server:latest
docker push yesha123/multi-worker:latest

docker push yesha123/multi-client:$SHA
docker push yesha123/multi-server:$SHA
docker push yesha123/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yesha123/multi-server:$SHA
kubectl set image deployments/client-deployment client=yesha123/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yesha123/multi-worker:$SHA
