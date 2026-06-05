# OPTIM-ON Home Assistant Add-ons

OPTIM-ON is an energy optimization system by DOMOPTI S.R.L.S. It runs inside Home
Assistant and exposes a local web dashboard. This repository distributes OPTIM-ON
as installable Home Assistant add-ons — it packages the OPTIM-ON application image
into the add-on format and does not contain the application source.

## Add-ons

| Add-on | Channel | Updates | Image signing |
|---|---|---|---|
| **OPTIM-ON** | Stable | On each tagged release | Cosign-signed |
| **OPTIM-ON Edge** | Experimental | On every push to `main` | Unsigned |

Install **OPTIM-ON** for normal use. **OPTIM-ON Edge** tracks the latest
development build and may be unstable. The two use different host ports, so they
can be installed side by side.

## Installation

1. In Home Assistant, open **Settings → Add-ons → Add-on Store**.
2. Open the **⋮** (three-dot) menu, top right → **Repositories**.
3. Add `https://github.com/DOMOPTI/HA-addons` and close the dialog.
4. Find **DOMOPTI HA Addons** in the store and install **OPTIM-ON** (or
   **OPTIM-ON Edge** for testing).
5. Configure (see below), then **Start** the add-on. Open the dashboard with the
   add-on's **Open Web UI** button.

## Configuration

One option:

| Option | Type | Default | Effect |
|---|---|---|---|
| `reset_admin` | bool | `false` | When `true`, wipes the dashboard admin account on the next boot so it can be recreated through Home Assistant onboarding. Leave `false` for normal use, and set it back to `false` once the admin is recreated. |

See [docs/public/interfaces.md](docs/public/interfaces.md) for the full add-on
contract (ports, image names, versioning).

## Documentation

- [docs/public/architecture.md](docs/public/architecture.md) — how the add-on
  packaging works.
- [docs/public/interfaces.md](docs/public/interfaces.md) — the add-on
  configuration and interface contract.

---

Maintained by DOMOPTI S.R.L.S.
