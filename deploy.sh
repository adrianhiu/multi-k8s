docker build -t adrianhiu/multi-client:latest -t adrianhiu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t adrianhiu/multi-server:latest -t adrianhiu/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t adrianhiu/multi-worker:latest -t adrianhiu/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push adrianhiu/multi-client:latest
docker push adrianhiu/multi-server:latest
docker push adrianhiu/multi-worker:latest

docker push adrianhiu/multi-client:$SHA
docker push adrianhiu/multi-server:$SHA
docker push adrianhiu/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=adrianhiu/multi-server:$SHA
kubectl set image deployment/client-deployment client=adrianhiu/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=adrianhiu/multi-worker:$SHA
