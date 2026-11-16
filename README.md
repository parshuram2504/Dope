# Dope
Dope is a ecommerce application

## Deploy with Helm

Install the chart from the repository root:

```sh
helm install dope ./helm-chart
```

By default, the chart creates a single-replica Deployment and an internal
ClusterIP Service. To expose the site through an Ingress, create an override
values file:

```sh
cat > ingress-values.yaml <<'EOF'
ingress:
  enabled: true
  hosts:
    - host: dope.example.com
      paths:
        - path: /
          pathType: Prefix
EOF

helm upgrade --install dope ./helm-chart -f ingress-values.yaml
```

Override chart settings with `--set` or a values file. For example, set
`image.tag` to deploy a different Docker image version. To remove the release,
run `helm uninstall dope`.

## Jenkins Helm pipeline

The Jenkins pipeline requires the Helm CLI on its agent. It lints the chart,
renders it with ingress both disabled and enabled, and packages it before
building and pushing the Docker image. Each build packages a chart version
`0.1.<BUILD_NUMBER>` with `appVersion` set to `<BUILD_NUMBER>`; the chart
defaults its image tag to `appVersion`, so it references that build's Docker
image. The package is archived as a fingerprinted Jenkins build artifact. The
existing `jenkins_docker` credential is used to push the image.
