# Internal documentation

HA-addons is a **public** GitHub repository. Internal and operational
documentation for the add-on wrapper — the CI/build pipeline, the release
procedure, and operational gotchas — is **not** kept here. It lives in the private
`optim-on-iac` repository:

    optim-on-iac/docs/internal/wrappers/

This keeps implementation and operational detail behind the public/internal
boundary while the add-on definitions and their public contract stay here.

## What stays in HA-addons

- Add-on definitions: `optim-on/`, `optim-on-edge/`.
- Public contract: [`docs/public/`](../public/) — architecture and interface docs.

## What lives in optim-on-iac

- Build/release runbook, CI pipeline notes, the manual base-image bump procedure,
  and operational gotchas.

For the bundled application internals (dashboard, worker), see the
`optim-on-local-agent` documentation, not this repo.
