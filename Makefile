image:
	buildah bud --tag hellopy
run:
	podman run --name hellopy --publish 8080:8080 localhost/hellopy:latest
clean:
	-podman stop hellopy
	-podman rm hellopy
	-podman rmi hellopy:latest

registry:
	podman tag localhost/hellopy:latest quay.io/manue/hellopy:latest
	podman login quay.io 
	podman push quay.io/manue/hellopy:latest

kube-deploy:
	kubectl apply -f hellokube-deployment.yaml

shift-service:
	oc new-app --strategy=source https://github.com/EmmanuelKasper/podman2kube2shift.git

shift-update:
	oc start-build podman2kube2shift

clean-kube:
	kubectl delete deployment/hellokube

clean-shift:
	oc delete all --selector app=podman2kube2shift

help:
	@echo target availables: image run registry kube-deploy shift-service shift-update
