# Add-on architecture

HA-addons packages the OPTIM-ON application — built and published as a container
image by `optim-on-local-agent` — into installable Home Assistant add-ons. This
repository is a **wrapper**: on top of a prebuilt base image it adds the add-on
metadata, a boot script, and the process-supervisor entrypoint. It contains no
application source.

> This document describes the wrapper. For what the bundled application does — the
> dashboard, worker, and optimizer integration — see the `optim-on-local-agent`
> documentation.

## The wrapper

Each add-on is a thin Docker image built `FROM` a base image:

- [`optim-on/Dockerfile:1-2`](../../optim-on/Dockerfile#L1) — `ARG BUILD_FROM` /
  `FROM $BUILD_FROM`. The base image is supplied at build time, not hardcoded.
- [`optim-on/Dockerfile:29`](../../optim-on/Dockerfile#L29) — `ENV HOSTNAME=0.0.0.0`
  so the bundled web server binds all interfaces and HA can reach it.
- [`optim-on/Dockerfile:31-33`](../../optim-on/Dockerfile#L31) — copies
  [`run.sh`](../../optim-on/run.sh) and sets it as `CMD`.

The wrapper adds nothing else — no application code.

## Channels

Two add-ons track two release channels:

| | Stable (`optim-on`) | Edge (`optim-on-edge`) |
|---|---|---|
| Build trigger | GitHub release published | Push to `main` |
| Base image tag | Pinned (`prod-54`) | Rolling (`dev`) |
| Image signing | Cosign-signed | Unsigned |
| `stage` | (default) | `experimental` |
| Workflow | [`builder.yaml`](../../.github/workflows/builder.yaml) | [`builder-edge.yaml`](../../.github/workflows/builder-edge.yaml) |

Stable and edge can be installed simultaneously — they map to different host ports
(see [interfaces.md](interfaces.md)).

## Image flow

    optim-on-local-agent
      └─ builds & publishes the base image to ECR:
         prod: public.ecr.aws/g5p5a5k9/optim-on-local-agent-prod:prod-54  (pinned)
         dev:  public.ecr.aws/v0f8z0k0/optim-on-local-agent-dev:dev       (rolling)
            │
            ▼  BUILD_FROM (build.yaml)
    HA-addons wrapper
      └─ Dockerfile (FROM base) + run.sh + supervisord entrypoint
         └─ GitHub Actions builds amd64 + aarch64, pushes to:
            ghcr.io/domopti/{arch}-addon-optim-on[-edge]
            │
            ▼
    HA Supervisor
      └─ pulls the image, mounts /data, runs the add-on
            │
            ▼
    User  (Open Web UI → dashboard on port 3000)

Base-image updates are **manual**: when `optim-on-local-agent` ships a new prod
image, the `build_from` tag in
[`optim-on/build.yaml:1-3`](../../optim-on/build.yaml#L1) is bumped by hand and a
new release is cut. Nothing automatically links the add-on version to the
base-image tag.

## Boot sequence

[`run.sh`](../../optim-on/run.sh) is identical in both add-ons and runs at
container start:

1. [`run.sh:6-8`](../../optim-on/run.sh#L6) — recreate `/data/optim-on/database`
   and `/data/optim-on/plugins`, `chmod 755`. HA Supervisor mounts `/data` as a
   volume at runtime, wiping directories created during the image build, so they
   are recreated on every boot.
2. [`run.sh:13-16`](../../optim-on/run.sh#L13) — if `/data/options.json` has
   `reset_admin: true`, export `OPTIMON_RESET_ADMIN=1` for this boot (effect
   documented in [interfaces.md](interfaces.md)).
3. [`run.sh:18`](../../optim-on/run.sh#L18) — `exec supervisord -n -c
   /etc/supervisor/supervisord.conf`. The supervisor config and the processes it
   starts live in the base image, not here.

## Build pipeline

Both workflows build `amd64` + `aarch64` via QEMU + Buildx and push to GHCR.

- **Stable** — [`builder.yaml`](../../.github/workflows/builder.yaml): triggers on
  [`release: published`](../../.github/workflows/builder.yaml#L3-L5); reads
  `BUILD_FROM` from `optim-on/build.yaml`; tags the image with the release tag
  ([`builder.yaml:57`](../../.github/workflows/builder.yaml#L57)); signs each image
  with Cosign ([`builder.yaml:68-74`](../../.github/workflows/builder.yaml#L68)).
- **Edge** — [`builder-edge.yaml`](../../.github/workflows/builder-edge.yaml):
  triggers on [`push` to `main`](../../.github/workflows/builder-edge.yaml#L3-L6);
  tags the image with the `version` read from `optim-on-edge/config.yaml`
  ([`builder-edge.yaml:46-49`](../../.github/workflows/builder-edge.yaml#L46)). No
  signing step.
