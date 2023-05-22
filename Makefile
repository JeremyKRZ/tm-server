TM_SERVER_IMAGE_TAG=jeremykrz/tm-server:latest

build_server_image:
	docker build server -t ${TM_SERVER_IMAGE_TAG}
	docker image push ${TM_SERVER_IMAGE_TAG}

update:
	python scripts/upload_maps.py
	kubectl apply -f kube/server-configmap.yaml
	kubectl apply -f kube/matchsettings-configmap.yaml
	kubectl apply -f kube/pyplanet-configmap.yaml
	kubectl apply -f kube/deployment.yaml
	kubectl apply -f kube/service.yaml
	kubectl apply -f kube/ingress.yaml

delete_all:
	kubectl delete deployments,statefulsets,daemonsets,replicasets --all
	kubectl delete services --all
	kubectl delete pvc --all
	kubectl delete pv --all

reset:
	make delete_all
	make update
	kubectl get pods