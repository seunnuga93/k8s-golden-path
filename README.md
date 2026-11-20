# k8s-golden-path

A reference **"golden path"** for deploying a service to Kubernetes the right way — a Helm chart with the reliability defaults built in, an Argo CD Application for GitOps delivery, and a CI pipeline that lints and validates every change.

The idea: teams shouldn't reinvent probes, autoscaling and disruption budgets for every service. Give them one safe, repeatable template to copy, so the easy path is also the safe path.

## What's in the box
```
chart/                 # Helm chart with reliability defaults
  templates/
    deployment.yaml    # readiness + liveness probes, resource requests/limits, securityContext
    service.yaml
    hpa.yaml           # HorizontalPodAutoscaler
    pdb.yaml           # PodDisruptionBudget (stay available during node drains)
    ingress.yaml
argocd/application.yaml # GitOps delivery via Argo CD (automated sync + self-heal)
monitoring/servicemonitor.yaml  # Prometheus scrape config
.github/workflows/ci.yaml       # helm lint + template validation on every PR
```

## Reliability defaults (the point of the repo)
- **Readiness & liveness probes** — Kubernetes only sends traffic to healthy pods and restarts stuck ones.
- **Resource requests & limits** — predictable scheduling, and no noisy-neighbour or OOM surprises.
- **HPA** — scale with load instead of over-provisioning.
- **PodDisruptionBudget** — keep a minimum number of pods during voluntary disruptions (node drains, upgrades).
- **Rolling updates** with `maxUnavailable`/`maxSurge` — ship with zero downtime.
- **GitOps via Argo CD** — Git is the source of truth; rollback is a `git revert`.

## Quickstart
```bash
# Lint and render locally
helm lint chart/
helm template demo chart/ --values chart/values.yaml

# Install
helm install demo chart/ --namespace demo --create-namespace

# Or deliver via Argo CD
kubectl apply -f argocd/application.yaml
```

## Why it matters
This is platform-as-product in miniature: encode best practice once as a reusable building block so every team ships safely and consistently, without each service becoming a one-off.

## License
MIT
