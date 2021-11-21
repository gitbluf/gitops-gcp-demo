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

Shortcuts for terraform:<br>
- bucket was created manually(terragrunt can handle)
- dns record was created manually after nginx-controller provisions LB(external_dns operator can handle this)
- firewall rule was added for nginx-controller in GKE(8443), this can be done with terraform

For GitOps I went with FluxV2.<br>

Bootstrap command can found in terraform/scripts/bootstrap.sh <br>

What time is it app repository was [FORKED](https://github.com/gitbluf/what-time-is-it) <br> and [PIPELINE](https://github.com/gitbluf/what-time-is-it/blob/master/.github/workflows/main.yaml) for image building was setup using GitHub Actions.

During the pipeline image is [pushed](https://hub.docker.com/r/mpetrovic992/time-app/tags) <br>

Image automation is also set and will trigger base on image policy(current semver-range 1.x.x <br>

When new image is scanned image-automation-controller will update manifests and push to repo under flux-image-updates/time-app branch. <br>

[Pipeline](https://github.com/gitbluf/gitops-gke-demo/actions/runs/1487874135) will trigger and [PR](https://github.com/gitbluf/gitops-gke-demo/pull/1) will be made. <br>

Running flux cli we can see info about image automation:

``` bash
➜  gitops-gke-demo git:(main) ✗ flux get image all -A
NAMESPACE        NAME                            READY   MESSAGE                         LAST SCAN                       SUSPENDED 
flux-system     imagerepository/time-app        True    successful scan, found 3 tags   2021-11-21T23:48:29+01:00       False           

NAMESPACE       NAME                    READY   MESSAGE                                                                 LATEST IMAGE                 
flux-system     imagepolicy/time-app    True    Latest image tag for 'mpetrovic992/time-app' resolved to: v1.0.3        mpetrovic992/time-app:v1.0.3    

NAMESPACE       NAME                            READY   MESSAGE         LAST RUN                        SUSPENDED 
flux-system     imageupdateautomation/time-app  True    no updates made 2021-11-21T23:47:32+01:00       False           

```

## APP
URL: https://time-app.asg15.casual-trading.com <br>
SSL Report: https://www.ssllabs.com/ssltest/analyze.html?d=time-app.asg15.casual-trading.com&hideResults=on
