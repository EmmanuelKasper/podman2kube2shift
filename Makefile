VERSION = 5

image:
	buildah bud --tag hellopy:$(VERSION)
run:
	podman run --name hellopy --publish 8080:8080 localhost/hellopy:$(VERSION)
clean:
	-podman stop hellopy
	-podman rm hellopy
	-podman rmi hellopy:$(VERSION)

registry:
	podman tag localhost/hellopy:$(VERSION) quay.io/manue/hellopy:$(VERSION)
	podman login quay.io 
	podman push quay.io/manue/hellopy:$(VERSION)

deployment:
	oc create -f k8s-manifests/ns.yaml
	oc create -f k8s-manifests/deploy.yaml

nodeport-service:
	oc create -f k8s-manifests/svc-nodeport.yaml

shift-service:
	oc new-app --strategy=source https://github.com/EmmanuelKasper/podman2kube2shift.git

shift-update:
	oc start-build podman2kube2shift

gitops-create:
	-oc new-project hello
	oc label namespace hello argocd.argoproj.io/managed-by=openshift-gitops
	oc create -f application.yaml

clean-gitops:
	oc delete -f application.yaml

clean-kube:
	kubectl delete deployment/hellokube

clean-shift:
	oc delete all --selector app=podman2kube2shift

help:
	@echo target availables: image run registry kube-deploy shift-service shift-update
