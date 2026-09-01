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
- **Traefik**: reverse proxy, discovers containers via podman socket. Routing is configured via container labels (`traefik.http.routers.*`, `traefik.http.services.*`). Listens on systemd socket-activated ports (http, https, https-tailnet, irc).
- **Local builds**: services with a `.build` file build from source in a `src/` subdir. The container's `Image=` references `<name>.build`. These have `AutoUpdate=local`.
- **Registry images**: services using upstream images set `Image=` to a registry URL and `AutoUpdate=registry`.
- **All services** have `WantedBy=default.target` — starting `default.target` brings everything up.
- **Build services** have `WantedBy=build-all.target`.

## Tailscale

- sam is a tailnet node: hostname `sam`, tailscale IPs via `ssh sam tailscale ip`. tailscaled runs as a system service on the host (not containerized).
- **Subnet router**: advertises the LAN subnet only (`192.168.1.0/24`). Public services are reached over the plain internet even from tailnet devices.
- **DNS is public-only** (Cloudflare, both records DNS-only, no proxy):
  - `*.senan.xyz` → sam's public IP — public services
  - `*.i.senan.xyz` → sam's tailscale IP — internal services, only reachable over the tailnet
  - Deliberately no in-tailnet resolver: pointing tailnet clients at a tailnet-IP resolver breaks Android's DNS forwarder (tailscale/tailscale#20983) and keeps the phone's tunnel warm for every background query (radio never sleeps, ~35% battery).
- **Tailnet DNS config** (admin console): MagicDNS **on**; global nameserver = `https://adblock.dns.mullvad.net/dns-query` (ad-blocking DoH, reached outside the tunnel). Careful: the DoH provider must be a *known provider* in tailscale's `net/dns/publicdns` (has compiled-in bootstrap IPs) — an unknown one (e.g. AdGuard) deadlocks and kills DNS on every accept-dns device.
- **ACL `nodeAttrs`**: `silent-disco` for all devices — suppresses magicsock's 3s disco heartbeats (mobile battery).
- sam has `--accept-dns=false` (device state via `tailscale set`, not in the repo): the server's DNS stays independent of tailnet DNS config.
- **Public vs tailnet-only services**: two Traefik entrypoints, both `asDefault: true`:
  - `web` — public, socket `https.socket` bound to the LAN IP on 443 (router forwards 80/443 here)
  - `web-tailnet` — socket `https-tailnet.socket` bound to the tailscale IPs
  - Private services use a `<name>.i.senan.xyz` hostname **and** set `Label=traefik.http.routers.<name>.entrypoints=web-tailnet` — they don't exist on the public entrypoint (404). No explicit entrypoints label = public (serves on both), named `<name>.senan.xyz`.
  - Cert SANs: `*.senan.xyz` and `*.i.senan.xyz` wildcards via ACME DNS-01 (Cloudflare), configured in `traefik/config/traefik.yml`.
- **Direct-published ports**: syncthing 22000, IRC 6697, and camera RTSP 8554 bind the tailscale IP (tailnet-only).
- **Router port forwards**: only 80, 443, and transmission's peer port. sshd (port 22) is tailnet-only — no WAN forward.
- **Cross-service calls** use container names (`http://systemd-<name>:<port>`), never `*.senan.xyz` hostnames.
- Socket units live in `~/projects/sam/home/.config/systemd/user/` and are `systemctl --user link`ed.

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
