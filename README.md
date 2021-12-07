# GITOPS WITH FLUX ON GCP-GKE

For simplicity both k8s and terraform manifests live in the same repository seperated only by directories.<br>

Repo structure: <br>

```bash
.
├── LICENSE
├── README.md
├── gitops
│   ├── apps
│   │   └── time-app
│   │       ├── base
│   │       │   ├── git-chart-source.yaml
│   │       │   ├── kustomization.yaml
│   │       │   ├── namespace.yaml
│   │       │   └── release.yaml
│   │       ├── production
│   │       │   ├── image-automation.yaml
│   │       │   ├── kustomization.yaml
│   │       │   └── release.yaml
│   │       └── staging
│   ├── clusters
│   │   └── production
│   │       ├── cert-manager
│   │       │   └── cert-manager-sync.yaml
│   │       ├── flux-system
│   │       │   ├── gotk-components.yaml
│   │       │   ├── gotk-sync.yaml
│   │       │   └── kustomization.yaml
│   │       ├── nginx
│   │       │   └── nginx-sync.yaml
│   │       └── time-app
│   │           └── time-app-sync.yaml
│   ├── infrastructure
│   │   └── nginx
│   │       ├── base
│   │       │   └── kustomization.yaml
│   │       └── production
│   │           └── kustomization.yaml
│   └── operators
│       └── cert-manager
│           ├── base
│           │   ├── cluster-issuer-prod.yaml
│           │   ├── cluster-issuer-stage.yaml
│           │   └── kustomization.yaml
│           └── production
│               └── kustomization.yaml
└── terraform
    ├── backend.tf
    ├── locals.tf
    ├── main.tf
    ├── outputs.tf
    ├── plan.tfplan
    ├── provider.tf
    ├── scripts
    │   └── bootstrap.sh
    ├── variables.tf
    └── vpc.tf

22 directories, 30 files
```

GitOps agent: [FluxV2](https://fluxcd.io/)

Bootstrap command can found in terraform/scripts/bootstrap.sh <br>

