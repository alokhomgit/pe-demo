#!/usr/bin/env bash

# Copyright 2024 Stefan Prodan
# SPDX-License-Identifier: AGPL-3.0

set -o errexit

cluster_name="${CLUSTER_NAME:=flux}"
#registry="${cluster_name}-registry:5000"
registry="ghcr.io/alokhom/oci-repo"

install_flux_operator() {
helm -n flux-system upgrade --install flux-operator oci://ghcr.io/controlplaneio-fluxcd/charts/flux-operator --create-namespace --wait
}

install_flux_instance() {
kubectl apply -f ../clusters/dev/FluxInstance.yaml 
#  helm -n flux-system upgrade --install "${cluster_name}" oci://ghcr.io/controlplaneio-fluxcd/charts/flux-instance -f ../clusters/dev/FluxInstance.yaml --wait
# cat <<EOF | helm -n flux-system upgrade --install flux oci://ghcr.io/controlplaneio-fluxcd/charts/flux-instance --values -
# instance:
#   distribution:
#     version: "2.5.x"
#     registry: "ghcr.io/fluxcd"
#     artifact: "oci://ghcr.io/controlplaneio-fluxcd/flux-operator-manifests"
#   cluster:
#     type: kubernetes
#     multitenant: false
#     networkPolicy: true
#     domain: "cluster.local"
#   components:
#     - source-controller
#     - kustomize-controller
#     - helm-controller
#     - notification-controller
#     - image-reflector-controller
#     - image-automation-controller
#   sync:
#     kind: OCIRepository
#     url: oci://${registry}/flux-cluster-sync
#     ref: "refs/heads/main"
#     path: "clusters/dev"
#   kustomize:
#     patches:
#       - target:
#           kind: OCIRepository
#         patch: |
#           - op: add
#             path: /spec/insecure
#             value: true
#       - target:
#           kind: Deployment
#           name: "(kustomize-controller|helm-controller)"
#         patch: |
#           - op: add
#             path: /spec/template/spec/containers/0/args/-
#             value: --concurrent=10
#           - op: add
#             path: /spec/template/spec/containers/0/args/-
#             value: --requeue-dependency=5s
# EOF
}

install_flux_operator
install_flux_instance

echo "Waiting for Flux controllers to be ready"
kubectl -n flux-system wait --for=condition=Ready fluxinstance/flux --timeout=5m
flux check
echo "✔ Flux is ready"

echo "Waiting for cluster addons sync to complete"
kubectl -n flux-system wait --for=condition=Ready kustomization/infra-controllers --timeout=5m
flux tree kustomization infra-controllers

echo "Waiting for apps sync to complete"
kubectl -n flux-system wait --for=condition=Ready kustomization/apps-sync --timeout=5m
flux tree kustomization apps-sync

echo "✔ Cluster is ready"
