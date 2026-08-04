---
description: Interact with the "sam" home server - manage podman containers, quadlet services, troubleshoot issues
argument-hint: "<task>"
---
# Server "sam" - Home Server Management

Task: $@

## Connection

- **SSH**: `ssh sam <cmd>` (or `ssh sam` for interactive) - host, port, and user come from ssh config
- **OS**: Debian (x86_64), kernel 6.12+

## System Layout

- `/mnt/media` — RAID (`/dev/md0`) for media
- `/mnt/containers` — persistent container data/volumes (on NVMe)

## Podman & Quadlet Setup

- **Podman**, rootless, running as user `senan` (uid 1001)
- All services are **systemd quadlet** units (not docker-compose)
- Quadlet configs are **versioned** in `~/projects/sam/home/.config/containers/systemd/` and symlinked to `~/.config/containers/systemd/`
- Each service has its own subdirectory

### Quadlet file types

- `.container` — defines a container (image, volumes, env, labels, network)
- `.build` — builds an image from a Dockerfile in a `src/` subdirectory
- `.network` — defines a podman network
- `.volume` — defines a named volume

### Key patterns

- **Networking**: most containers join `reverse-proxy.network` (subnet 10.89.0.0/24). Some services have their own internal network (e.g. `x-internal.network`) for DB access.
- **Traefik**: reverse proxy, discovers containers via podman socket. Routing is configured via container labels (`traefik.http.routers.*`, `traefik.http.services.*`). Listens on systemd socket-activated ports (http, https, irc).
- **Local builds**: services with a `.build` file build from source in a `src/` subdir. The container's `Image=` references `<name>.build`. These have `AutoUpdate=local`.
- **Registry images**: services using upstream images set `Image=` to a registry URL and `AutoUpdate=registry`.
- **All services** have `WantedBy=default.target` — starting `default.target` brings everything up.
- **Build services** have `WantedBy=build-all.target`.

### Common commands

```sh
# Check service status
ssh sam systemctl --user status <service>.service

# Restart a service
ssh sam systemctl --user restart <service>.service

# View container logs
ssh sam podman logs systemd-<service>

# List running containers
ssh sam podman ps

# List all services
ssh sam systemctl --user list-units --type=service --no-pager

# Start everything
ssh sam systemctl --user start default.target

# Rebuild and restart a locally-built service
ssh sam systemctl --user restart <service>-build.service
ssh sam systemctl --user restart <service>.service
```
