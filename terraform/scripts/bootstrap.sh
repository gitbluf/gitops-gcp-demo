#!/usr/bin/env bash

echo "======= CONFIGURING KUBECONFIG ========="

gcloud container clusters get-credentials $(terraform output -raw kubernetes_cluster_name) --region $(terraform output -raw region)

echo "======== BOOTSTRAPING FLUX ========="

flux bootstrap github \
--owner=gitbluf \
--repository=gitops-gke-demo \
--path=gitops/clusters/production \
--components-extra=image-reflector-controller,image-automation-controller \
--read-write-key \
--personal
