build-image:
	buildah bud --tag hellopy
run:
	podman run --name hellopy --publish 5000:5000 localhost/hellopy:latest
clean:
	-podman stop hellopy
	-podman rm hellopy
	-podman rmi hellopy:latest

push:
	podman tag localhost/hellopy:latest quay.io/manue/hellopy:latest
	podman login quay.io 
	podman push quay.io/manue/hellopy:latest

kube:
	kubectl apply -f deployment.yaml

clean-cluster:
	kubectl delete deployment/hellokube

help:
	@target availables: build-image run (clean) push kube (clusterclean)
