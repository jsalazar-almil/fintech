NAMESPACE=acitypay-dev

.PHONY: status
status:
	kubectl get pods -n $(NAMESPACE)
	kubectl get svc -n $(NAMESPACE)

.PHONY: deploy-dev
deploy-dev:
	kubectl apply -f k8s/base/namespace.yaml
	kubectl apply -f k8s/base/configmap.yaml
	kubectl apply -f k8s/base/secret.yaml
	kubectl apply -f k8s/base/postgres.yaml
	kubectl apply -f k8s/base/minio.yaml
	kubectl apply -f k8s/base/sftp-mock.yaml

.PHONY: delete-dev
delete-dev:
	kubectl delete namespace $(NAMESPACE)

.PHONY: logs-postgres
logs-postgres:
	kubectl logs -n $(NAMESPACE) deploy/postgres

.PHONY: logs-minio
logs-minio:
	kubectl logs -n $(NAMESPACE) deploy/minio

.PHONY: logs-sftp
logs-sftp:
	kubectl logs -n $(NAMESPACE) deploy/sftp-mock

.PHONY: pf-minio
pf-minio:
	kubectl port-forward -n $(NAMESPACE) svc/minio 9000:9000 9001:9001

.PHONY: pf-postgres
pf-postgres:
	kubectl port-forward -n $(NAMESPACE) svc/postgres 5432:5432

.PHONY: pf-sftp
pf-sftp:
	kubectl port-forward -n $(NAMESPACE) svc/sftp-mock 2222:22
