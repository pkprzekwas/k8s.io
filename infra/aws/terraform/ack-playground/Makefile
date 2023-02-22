TF ?= terraform
TF_PLAN ?= ack-playground.plan
K ?= kubectl

.PHONY: init
init:
	$(TF) init

.PHONY: plan
plan:
	$(TF) plan -out $(TF_PLAN)

.PHONY: apply
apply:
	$(TF) apply $(TF_PLAN)

.PHONY: destroy
destroy:
	$(TF) destroy

.PHONY: output
output:
	@$(TF) output -json

.PHONY: update-kubeconfig
update-kubeconfig:
	# **NOTE**
	# You may need to manually update output kubeconfig:
	# s#client.authentication.k8s.io/v1alpha1#client.authentication.k8s.io/v1beta1#g
	aws eks --region $$($(TF) output -raw region) update-kubeconfig --name $$($(TF) output -raw cluster_name)

.PHONY:
wait:
	@$(K) cluster-info
	@sleep 3

# Installing ACK controllers
.PHONE: install-s3-ctrl
install-s3-ctrl: wait
	./hack/$@.sh

