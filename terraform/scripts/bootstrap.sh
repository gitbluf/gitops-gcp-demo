#!/usr/bin/env bash

echo "======= CONFIGURING KUBECONFIG ========="

gcloud container clusters get-credentials $(terraform output -raw kubernetes_cluster_name) --region $(terraform output -raw region)

echo "======== BOOTSTRAPING FLUX ========="

flux bootstrap git \
--url=ssh://git@github.com/gitbluf/gitops-gke-demo \
--branch=master \
--path=gitops/clusters/production \
--private-key-file=$HOME/.ssh/fluxinator

