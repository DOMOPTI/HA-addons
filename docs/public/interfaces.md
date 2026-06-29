# Add-on interface contract

The configuration and interface contract for both add-ons. Source of record:
[`optim-on/config.yaml`](../../optim-on/config.yaml) and
[`optim-on-edge/config.yaml`](../../optim-on-edge/config.yaml). For how the add-on
is built and boots, see [architecture.md](architecture.md).

## config.yaml fields

| Field | `optim-on` (stable) | `optim-on-edge` (edge) |
|---|---|---|
| `name` | `OPTIM-ON` | `OPTIM-ON Edge` |
| `version` | `2026.21.5` | `2026.21.5e0000` |
| `slug` | `optim_on` | `optim_on_edge` |
| `arch` | `aarch64`, `amd64` | `aarch64`, `amd64` |
| `stage` | (default) | `experimental` |
| `init` | `false` | `false` |
| `startup` | `application` | `application` |
| `boot` | `auto` | `auto` |
| `ports` | `3000/tcp: 80` | `3000/tcp: 3000` |
| `webui` | `http://[HOST]:[PORT:3000]` | `http://[HOST]:[PORT:3000]` |
| `homeassistant_api` | `true` | `true` |
| `image` | `ghcr.io/domopti/{arch}-addon-optim-on` | `ghcr.io/domopti/{arch}-addon-optim-on-edge` |
| `options` | `reset_admin: false` | `reset_admin: false` |
| `schema` | `reset_admin: bool` | `reset_admin: bool` |

Anchors: stable [`optim-on/config.yaml:1-20`](../../optim-on/config.yaml#L1);
edge [`optim-on-edge/config.yaml:1-21`](../../optim-on-edge/config.yaml#L1).

Field meanings (Home Assistant add-on schema):

| Field | Meaning |
|---|---|
| `init: false` | HA injects no init; the image entrypoint (`run.sh` → supervisord) is the init. |
| `startup: application` | Started in the `application` phase, after core services. |
| `boot: auto` | Starts automatically on HA boot. |
| `homeassistant_api: true` | The add-on is granted access to the Home Assistant API. |
| `webui` | Template HA resolves to the dashboard URL; `[PORT:3000]` resolves to the host port mapped from container port `3000`. |

## Ports

| Add-on | Mapping | Dashboard reachable on |
|---|---|---|
| `optim-on` | container `3000/tcp` → host `80` | host port `80` |
| `optim-on-edge` | container `3000/tcp` → host `3000` | host port `3000` |

The host ports differ **by design**: stable on `80`, edge on `3000`, so both
add-ons can be installed and run simultaneously without a port clash. Anchors:
[`optim-on/config.yaml:12-13`](../../optim-on/config.yaml#L12),
[`optim-on-edge/config.yaml:13-14`](../../optim-on-edge/config.yaml#L13).

## Options

One user option, identical in both add-ons.

| Option | Type | Default |
|---|---|---|
| `reset_admin` | `bool` | `false` |

- **`false` (normal):** no effect.
- **`true`:** on the **next boot** the bundled application wipes the dashboard
  `users` and `sessions` tables (per
  [`run.sh:10-12`](../../optim-on/run.sh#L10)) so the admin account can be
  recreated through Home Assistant onboarding. [`run.sh`](../../optim-on/run.sh)
  translates the option into the `OPTIMON_RESET_ADMIN=1` environment variable
  ([`run.sh:13-16`](../../optim-on/run.sh#L13)); the wipe itself runs inside the
  base image.

> Set the option back to `false` after the admin is recreated, or the wipe repeats
> on every subsequent boot.

The wipe is destructive to dashboard accounts. It does not touch persisted data
under `/data/optim-on/` (see the boot sequence in
[architecture.md](architecture.md)).

## Published images

| Channel | Image | Tag | Signing |
|---|---|---|---|
| Stable | `ghcr.io/domopti/{arch}-addon-optim-on` | release tag (e.g. `2026.21.5`) | Cosign-signed |
| Edge | `ghcr.io/domopti/{arch}-addon-optim-on-edge` | `version` from `config.yaml` | Unsigned |

`{arch}` is `amd64` or `aarch64`. Both channels are built and pushed by GitHub
Actions (see the build pipeline in [architecture.md](architecture.md)). Anchors:
[`builder.yaml:57`](../../.github/workflows/builder.yaml#L57),
[`builder.yaml:68-74`](../../.github/workflows/builder.yaml#L68),
[`builder-edge.yaml:62`](../../.github/workflows/builder-edge.yaml#L62).

## Versioning

Calendar-based, `YYYY.WW.x` — year, week, and a patch/build counter. Edge appends
an `e####` suffix.

| | Example | Set in |
|---|---|---|
| Stable | `2026.21.5` | [`optim-on/config.yaml:2`](../../optim-on/config.yaml#L2) |
| Edge | `2026.21.5e0000` | [`optim-on-edge/config.yaml:2`](../../optim-on-edge/config.yaml#L2) |

The literal `version` strings above are verified against `config.yaml`. The
`YYYY.WW.x` field semantics — year, ISO week, patch counter — are inferred from
the observed values; no source file defines the scheme.
