# Free API Gateways — Complete Guide & Comparison 2026

> All gateways listed here are **open-source and free to self-host**.  
> Infrastructure costs (compute, networking) typically run $500–2,000/month for production workloads.

---

## What is an API Gateway?

An API gateway is a server that sits between your clients and your backend services. Every request flows through it, giving you a single place to enforce policies across all your APIs.

```
Client (App/Browser)
       ↓
  [ API Gateway ]   ← auth, rate limiting, routing, logging, caching
       ↓
  ┌────────────┬────────────┬────────────┐
  │ User Svc   │ Order Svc  │ Payment Svc│
  └────────────┴────────────┴────────────┘
```

### Core Functions

| Function | Description |
|---|---|
| 🔐 **Authentication & Authorization** | Validates API keys, JWT tokens, OAuth2 — once, centrally |
| ⏱️ **Rate Limiting** | Limit requests per client/IP per second or day |
| ↔️ **Routing & Load Balancing** | Route to the right service; canary, A/B, weighted splits |
| 📊 **Observability** | Centralized logs, metrics, and distributed tracing |
| 🔄 **Request Transformation** | Modify headers, rewrite paths, aggregate multiple backends |
| 💾 **Caching** | Cache responses at the gateway layer to reduce backend load |

---

## The 7 Best Free API Gateways

### 1. Kong Gateway (OSS)

**The most widely adopted open-source gateway**

Built on NGINX + LuaJIT. Largest community and plugin ecosystem in the space — 300K+ monthly instances, 15M+ Docker pulls. The OSS edition is fully production-capable for most teams.

#### Specs

| Property | Value |
|---|---|
| License | Apache 2.0 |
| Language | Lua / NGINX |
| Max throughput | ~30K RPS (single node) |
| Latency overhead | 1–3ms |
| Config store | PostgreSQL / Cassandra |
| Protocols | HTTP, HTTPS, gRPC, WebSocket, TCP |

#### Pros
- Largest plugin ecosystem (~60 OSS plugins, hundreds from community)
- Massive, active community — easiest to find help and examples
- Kubernetes-native via Kong Ingress Controller
- REST Admin API + web UI (Kong Manager)
- AI proxy plugins for LLM traffic (added 2024–25)
- Clear enterprise upgrade path (Kong Konnect)

#### Cons
- Requires PostgreSQL or Cassandra — adds operational complexity for HA
- 1–3ms latency overhead with plugins (vs <1ms for APISIX)
- RBAC, analytics, and advanced features locked to paid Enterprise tier
- Primary plugin language is Lua — less familiar to most developers

#### Best for
Teams that want a battle-tested gateway with maximum plugin flexibility and a large support community. Default choice if you're new to API gateways.

---

### 2. Apache APISIX

**Highest throughput, fully dynamic, no database on the data path**

Built on NGINX + LuaJIT with etcd as the config store. Benchmarks consistently show 2–4× faster than Kong with 30–50% lower latency. Processing over 1 trillion API calls daily across production deployments (Tencent, NASA, and others).

#### Specs

| Property | Value |
|---|---|
| License | Apache 2.0 |
| Language | Lua / NGINX + multi-language plugins |
| Max throughput | 23K–50K+ QPS (single node) |
| Latency overhead | <1ms |
| Config store | etcd (no DB on data path) |
| Protocols | HTTP, HTTPS, gRPC, WebSocket, TCP, UDP |

#### Pros
- Best-in-class performance: sub-millisecond overhead
- Fully dynamic — config changes applied with zero restarts
- 100+ plugins; supports Lua, Go, Python, Node.js, and Java plugins
- etcd backend — no single point of failure, no database on request path
- Full Apache 2.0 license — no open-core gotchas
- Kubernetes Gateway API support and service mesh integration (GAMMA)

#### Cons
- Smaller community outside Asia-Pacific
- Documentation quality can be inconsistent
- Dashboard/UI less polished than Kong's
- Requires etcd knowledge for production deployment

#### Best for
Teams needing maximum throughput and lowest latency. Ideal for high-traffic microservices, cloud-native Kubernetes setups, and organizations wanting a fully vendor-neutral open-source gateway.

---

### 3. Tyk

**Full APIM stack in the OSS edition — analytics, developer portal, dashboard**

Written in Go. One of the few open-source gateways that ships a complete API management suite for free — including a developer portal, built-in analytics, and a dashboard. Multi-tenancy is also supported in the OSS version, which is rare.

#### Specs

| Property | Value |
|---|---|
| License | MPL 2.0 |
| Language | Go |
| Max throughput | ~20K RPS (single node) |
| Latency overhead | 1–3ms |
| Config store | Redis + MongoDB |
| Protocols | REST, GraphQL, gRPC, TCP, WebSocket |

#### Pros
- Full APIM stack for free: gateway + analytics + dashboard + developer portal
- Multi-tenancy support in OSS (rare among free gateways)
- Written in Go — easy to extend, predictable memory usage
- Excellent native GraphQL support
- Rated 4.8/5 on Gartner Peer Insights

#### Cons
- Smaller plugin ecosystem than Kong
- Higher latency than APISIX or KrakenD (Go vs NGINX architecture)
- UI has a learning curve for new users
- Community smaller than Kong's

#### Best for
Teams that want a developer portal and analytics included out of the box without enterprise fees. Also excellent for GraphQL or multi-tenancy needs from day one.

---

### 4. KrakenD

**Stateless, ultra-fast, built for BFF and API aggregation**

Stateless — no database, no node coordination, no shared state. Purely declarative via a JSON config file. Its standout feature is backend aggregation: fan out one client request to multiple backends and merge responses — the Backend for Frontend (BFF) pattern built-in. Backed by the Linux Foundation.

#### Specs

| Property | Value |
|---|---|
| License | Apache 2.0 (Community Edition) |
| Language | Go |
| Max throughput | 70K+ RPS (single node) |
| Latency overhead | <1ms |
| Config store | None — stateless JSON config file |
| Protocols | HTTP, HTTPS, gRPC, WebSocket |

#### Pros
- Highest raw throughput: 70K+ RPS on a single instance
- Truly stateless — no database, no Redis, no coordination between nodes
- Backend aggregation / BFF pattern built-in natively
- Declarative JSON config — CI/CD and GitOps friendly
- KrakenDesigner — visual config builder included
- OWASP-compliant, data-agnostic (stores no request data)

#### Cons
- No built-in developer portal or analytics dashboard
- Less plugin flexibility than Kong or APISIX
- Smaller community
- Some advanced features require paid Enterprise Edition

#### Best for
Teams building BFF layers, needing maximum throughput, or wanting a zero-database deployment. Perfect for performance-critical pipelines and CI/CD-driven declarative configuration.

---

### 5. Gravitee.io

**Event-native: REST, WebSocket, async, and event-driven APIs**

Event-native API management platform — uniquely strong at both synchronous (REST) and asynchronous (WebSocket, Kafka, MQTT, SSE) API management. Founded in France, popular with European organizations that need GDPR compliance and data sovereignty. Includes a full APIM suite.

#### Specs

| Property | Value |
|---|---|
| License | Apache 2.0 |
| Language | Java |
| Max throughput | Moderate (sync) / strong async |
| Latency overhead | 2–5ms |
| Config store | MongoDB + Elasticsearch |
| Protocols | REST, WebSocket, Kafka, MQTT, SSE, gRPC |

#### Pros
- Best async API support: WebSocket, Kafka, MQTT, Server-Sent Events
- Full APIM suite: gateway + developer portal + analytics + access management
- European-founded, strong GDPR and data sovereignty story
- Policy-driven configuration — no custom code needed for most use cases
- Community edition is fully featured for most organizations

#### Cons
- More complex setup than lighter alternatives
- Lower throughput than APISIX or KrakenD
- Java-based — higher memory footprint
- Smaller community than Kong

#### Best for
Event-driven architectures, organizations needing unified sync + async API management, and European teams with strict data sovereignty or GDPR requirements.

---

### 6. Envoy Gateway

**CNCF-standard, Kubernetes-native, service mesh backbone**

High-performance proxy originally built by Lyft, now a CNCF project. Envoy Gateway implements the Kubernetes Gateway API spec using Envoy as the data plane. It's the reference implementation used in the CKA/CKAD certification exams. Powers Istio — so it handles both north-south (ingress) and east-west (service mesh) traffic.

#### Specs

| Property | Value |
|---|---|
| License | Apache 2.0 |
| Language | C++ |
| Max throughput | Very high (C++ core) |
| Latency overhead | <1ms |
| Config store | xDS control plane |
| Protocols | HTTP/1.1, HTTP/2, gRPC, WebSocket, TCP, UDP |

#### Pros
- CNCF reference implementation for Kubernetes Gateway API
- Exceptional observability: native tracing, metrics, access logs
- Supports L4 and L7, HTTP/2, gRPC, WebSocket
- Powers Istio — unified gateway + service mesh data plane
- Wasm filter extensibility for custom logic
- mTLS between services out of the box

#### Cons
- Steep learning curve: xDS API, Wasm filters, complex configuration
- No built-in developer portal, API key management, or monetization
- Not a standalone API management solution — focused on traffic/infrastructure
- Usually deployed alongside another gateway for full API management features

#### Best for
Platform teams running Kubernetes who need advanced traffic management, a service mesh, and deep observability. Often used *alongside* an API management tool, not as a replacement.

---

### 7. Traefik

**Auto-discovery, Docker-native, zero-config for simple setups**

Cloud-native reverse proxy and load balancer with automatic service discovery. Reads Docker labels and Kubernetes annotations to configure itself — zero manual routing rules for simple environments. The easiest gateway to get started with, extremely popular in Docker Compose setups.

#### Specs

| Property | Value |
|---|---|
| License | MIT |
| Language | Go |
| Max throughput | ~15–20K RPS |
| Latency overhead | 1–2ms |
| Config store | Auto-discovery (Docker/K8s labels) |
| Protocols | HTTP, HTTPS, TCP, UDP, WebSocket, gRPC |

#### Pros
- Automatic service discovery — no manual route config needed
- Zero-config for Docker / Docker Compose setups
- Built-in Let's Encrypt / automatic HTTPS termination
- Lightweight Go binary — minimal resource usage
- Good Kubernetes Ingress and Gateway API support
- Built-in dashboard for traffic overview

#### Cons
- Enterprise features (distributed tracing, advanced auth) require paid Traefik Enterprise (~$600/mo)
- Less plugin flexibility than Kong or APISIX for complex API management
- Not suited for full API lifecycle management out of the box
- No built-in developer portal or analytics

#### Best for
Small teams, Docker/Compose setups, and projects that want zero-config routing with automatic HTTPS. Great starting point before graduating to Kong or APISIX at scale.

---

## Full Feature Comparison

| Feature | Kong OSS | APISIX | Tyk | KrakenD | Gravitee | Envoy GW | Traefik |
|---|---|---|---|---|---|---|---|
| **License** | Apache 2.0 | Apache 2.0 | MPL 2.0 | Apache 2.0 | Apache 2.0 | Apache 2.0 | MIT |
| **Language** | Lua/NGINX | Lua/NGINX | Go | Go | Java | C++ | Go |
| **Max RPS** | ~30K | 50K+ | ~20K | **70K+** | Moderate | Very high | ~15–20K |
| **Latency** | 1–3ms | **<1ms** | 1–3ms | **<1ms** | 2–5ms | **<1ms** | 1–2ms |
| **Auth (JWT/OAuth2)** | ✅ | ✅ | ✅ | ✅ | ✅ | 🟡 | 🟡 |
| **Rate limiting** | ✅ | ✅ | ✅ | ✅ | ✅ | 🟡 | ✅ |
| **gRPC** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **WebSocket** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **GraphQL** | 🟡 | 🟡 | ✅ | ➖ | ✅ | ➖ | ➖ |
| **Developer portal** | ➖ | ➖ | ✅ | ➖ | ✅ | ➖ | ➖ |
| **Built-in analytics** | 🟡 | 🟡 | ✅ | ➖ | ✅ | ➖ | 🟡 |
| **Web UI / dashboard** | ✅ | ✅ | ✅ | ✅ | ✅ | ➖ | ✅ |
| **Kubernetes-native** | ✅ | ✅ | ✅ | 🟡 | 🟡 | ✅ | ✅ |
| **Traffic splitting** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **BFF aggregation** | 🟡 | 🟡 | ➖ | ✅ | ➖ | ➖ | ➖ |
| **Async APIs (Kafka)** | ➖ | ➖ | ➖ | ➖ | ✅ | ➖ | ➖ |
| **Multi-tenancy (OSS)** | ➖ | ➖ | ✅ | ➖ | 🟡 | ➖ | ➖ |
| **Ease of setup** | Medium | Medium–Hard | Medium | Easy | Hard | Hard | **Easiest** |
| **Plugin system** | Lua / Go PDK | Lua + 5 langs | Go middleware | Go plugins | Java policies | C++ / Wasm | Go middlewares |
| **Config store** | PostgreSQL | etcd | Redis+MongoDB | None (JSON) | MongoDB+ES | xDS | Auto-discover |

> ✅ Native &nbsp;&nbsp; 🟡 Plugin/partial &nbsp;&nbsp; ➖ Not supported

---

## Decision Guide — Which One to Pick?

| If you need… | Use |
|---|---|
| The biggest community, most plugins, battle-tested in production | **Kong OSS** |
| Maximum throughput and lowest latency — sub-ms, no DB on data path | **Apache APISIX** |
| Developer portal + analytics + GraphQL included for free | **Tyk OSS** |
| No database, 70K+ RPS, or BFF aggregation layer | **KrakenD** |
| Async APIs (Kafka, MQTT), event-driven architecture, or EU data sovereignty | **Gravitee** |
| Kubernetes service mesh + gateway, mTLS, deep observability | **Envoy Gateway** |
| Quickest start — Docker Compose with auto-discovery and zero config | **Traefik** |

---

## Authentication Deep-Dive

Authentication is the most critical security layer — the gateway validates every identity before a request ever reaches your backend.

### Auth Methods Explained

| Method | How it works | Best for |
|---|---|---|
| 🔑 **API Key** | Shared secret in header/query. Fast, stateless. | Server-to-server over TLS |
| 🪙 **JWT** | Signed token with embedded claims. Self-contained — no DB lookup needed. | High-throughput APIs, microservices |
| 🔐 **OAuth 2.0** | Delegated authorization framework. Supports token introspection. | Third-party access, public APIs |
| 🌐 **OIDC** | OAuth 2.0 + identity layer (ID token). SSO with Okta, Auth0, Azure AD. | Single sign-on, enterprise |
| 🤝 **mTLS** | Both client & server verify certificates. Zero-trust machine identity. | Zero-trust, internal services |
| ✍️ **HMAC** | Request signature verification. Ensures integrity + authenticity. | Webhooks, policy enforcement (Tyk) |
| 🏢 **LDAP** | Active Directory / enterprise directory auth. | On-prem, intranet environments |

### Auth Support Matrix

| Auth Method | Kong OSS | APISIX | Tyk | KrakenD | Gravitee | Envoy GW | Traefik |
|---|---|---|---|---|---|---|---|
| API Key | ✅ | ✅ | ✅ | ✅ | ✅ | 🟡 | 🟡 |
| JWT (HS256/RS256) | ✅ | ✅ | ✅ | ✅ | ✅ | 🟡 | 🟡 |
| OAuth 2.0 | ✅ | ✅ | ✅ | 🟡 | ✅ | 🟡 | 🟡 |
| OpenID Connect | ✅ | ✅ | ✅ | 🟡 | ✅ | 🟡 | ➖ |
| mTLS | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | 🟡 |
| HMAC Signing | ✅ | ✅ | ✅ | ➖ | 🟡 | ➖ | ➖ |
| LDAP / Basic Auth | ✅ | ✅ | 🟡 | ➖ | ✅ | ➖ | 🟡 |
| RBAC (per-route) | 🟡 | ✅ | ✅ | ➖ | ✅ | 🟡 | ➖ |
| Multi-auth per route | 🟡 | ✅ | ✅ | ➖ | ✅ | ➖ | ➖ |
| Built-in WAF | ➖ | 🟡 | ➖ | ➖ | ➖ | ➖ | ✅ |
| Auth plugins count | ~15 | 10+ | 7+ | 4 | 8+ | 4 | 4 |

> ✅ Native &nbsp; 🟡 Plugin/partial &nbsp; ➖ Not supported in OSS

### Auth Winner by Use Case

| Use case | Best gateway |
|---|---|
| Max auth methods + multi-auth per route | **Apache APISIX** (10+ plugins, stackable) |
| Enterprise OIDC / SSO integration | **Kong OSS** or **Gravitee** |
| Zero-trust mTLS (machine-to-machine) | **Envoy Gateway** (native) |
| Built-in WAF + auto TLS | **Traefik** |
| HMAC + policy-based auth | **Tyk** |

> **Key insight**: APISIX allows stacking multiple authentication plugins on a single route — e.g., accept both JWT _and_ API key — and validates them with a single consumer abstraction. No restart required to add new auth methods.

---

## Performance Deep-Dive

### Throughput (RPS) — Single Node, Auth + Rate Limiting Enabled

| Gateway | Max RPS | Runtime | Relative |
|---|---|---|---|
| **KrakenD** | **70K+** | Go | ██████████ 100% |
| **Apache APISIX** | **50K+** | NGINX/LuaJIT | ████████░░ 71% |
| **Envoy Gateway** | Very high | C++ | ████████░░ ~70% |
| Kong OSS | ~30K | NGINX/LuaJIT | █████░░░░░ 43% |
| Tyk | ~20K | Go | ███░░░░░░░ 29% |
| Traefik | 15–20K | Go | ███░░░░░░░ 24% |
| Gravitee | Moderate | Java JVM | ██░░░░░░░░ ~15% |

> ⚠️ Numbers measured with realistic plugin chains (auth + rate limiting + logging). Passthrough-only benchmarks can be 2–3× higher — always test with your actual config.

### Latency Overhead Per Request

| Gateway | Latency added | Rating |
|---|---|---|
| Apache APISIX | **<1ms** | 🟢 Excellent |
| KrakenD | **<1ms** | 🟢 Excellent |
| Envoy Gateway | **<1ms** | 🟢 Excellent |
| Traefik | 1–2ms | 🟡 Good |
| Kong OSS | 1–3ms | 🟡 Good |
| Tyk | 1–3ms | 🟡 Good |
| Gravitee | 2–5ms | 🔴 Higher (JVM) |

### What Drives Latency — Key Factors

| Factor | Impact | Notes |
|---|---|---|
| **Runtime engine** | High | C++/LuaJIT < Go < JVM |
| **DB on data path** | High | PostgreSQL (Kong) adds round-trips; APISIX/KrakenD/Envoy avoid this |
| **Plugin chain length** | High | Each plugin adds ~0.1–0.5ms |
| **HTTP/2 support** | Medium | All 7 gateways support HTTP/2 |
| **Connection pooling** | Medium | NGINX event model (APISIX, Kong) handles concurrency efficiently |
| **Dynamic config** | Low | Config reload without restart (all except KrakenD) |
| **Response caching** | High benefit | Reduces backend load significantly for repeated requests |

### Performance Matrix

| Factor | Kong OSS | APISIX | Tyk | KrakenD | Gravitee | Envoy GW | Traefik |
|---|---|---|---|---|---|---|---|
| DB on data path | ❌ PostgreSQL | ✅ None (etcd) | 🟡 Redis | ✅ None | ❌ MongoDB | ✅ None | ✅ None |
| HTTP/2 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Connection pooling | ✅ | ✅ | ✅ | ✅ | 🟡 | ✅ | ✅ |
| Dynamic config (no restart) | ✅ | ✅ | ✅ | ➖ | ✅ | ✅ | ✅ |
| Response caching | ✅ | ✅ | ✅ | ✅ | ✅ | 🟡 | 🟡 |
| Circuit breaker | 🟡 | ✅ | ✅ | ✅ | ✅ | ✅ | 🟡 |

---

## Scalability Deep-Dive

### Scaling Architecture Overview

| Gateway | Scale model | Config store | Stateless? | HA complexity |
|---|---|---|---|---|
| Kong OSS | Horizontal | PostgreSQL | ❌ | Medium — DB is bottleneck |
| Apache APISIX | Horizontal | etcd cluster | ✅ data plane | Low — etcd HA straightforward |
| Tyk | Horizontal | Redis Cluster | 🟡 | Medium — Redis HA needed |
| **KrakenD** | **Horizontal** | **None (JSON file)** | **✅ 100%** | **Very Low — just add containers** |
| Gravitee | Horizontal | MongoDB + Elasticsearch | ✅ gateway nodes | High — two HA clusters needed |
| Envoy Gateway | Horizontal | xDS control plane | ✅ | Low — Kubernetes-native |
| Traefik | Horizontal | Auto-discovery | ✅ | Low — shared cert storage for HA |

### Per-Gateway Scalability Notes

**Kong OSS** — Scales horizontally; all nodes share PostgreSQL config store. DB becomes the HA bottleneck at very large deployments. Supports Cassandra as an alternative. Full Helm chart + HPA support. Best paired with a managed PostgreSQL (RDS, Cloud SQL) in production.

**Apache APISIX** — Best horizontal scaling story. etcd distributes config in milliseconds — no database on the request path. Add nodes without coordination penalty. Config changes propagate instantly with no restarts. Pairs perfectly with Kubernetes HPA.

**Tyk** — Scales horizontally with Redis Cluster for shared rate limit / session state. Async Pump process ships analytics without blocking requests. Hybrid mode lets OSS gateway nodes connect to a remote Dashboard for multi-region governance.

**KrakenD** — Simplest scaling of all. Truly stateless — no external dependencies. Just a Go binary + JSON config file. Deploy as many identical containers as you need behind a load balancer. Config changes require a rolling restart (bake new config into image). Ideal for Kubernetes HPA and blue-green deploys.

**Gravitee** — Gateway nodes themselves are stateless and scale well. However, management API, developer portal, and analytics require both MongoDB AND Elasticsearch in HA configuration — high operational overhead. Java JVM adds ~512MB–1GB memory per node.

**Envoy Gateway** — Designed for Kubernetes from the ground up. xDS control plane pushes config to stateless Envoy data plane nodes. Integrates natively with HPA, cluster autoscaler, and multi-cluster federation. Best Kubernetes scaling story overall.

**Traefik** — Stateless nodes scale easily. Gotcha: Let's Encrypt (ACME) certificate state needs shared storage in multi-replica setups (or use Traefik Hub). Great for small-to-mid traffic. Enterprise adds proper distributed rate limiting.

### Scalability Comparison Table

| Scalability factor | Kong OSS | APISIX | Tyk | KrakenD | Gravitee | Envoy GW | Traefik |
|---|---|---|---|---|---|---|---|
| Stateless data plane | ➖ | ✅ | 🟡 | ✅ | ✅ | ✅ | ✅ |
| Zero-downtime config reload | ✅ | ✅ | ✅ | ➖ | ✅ | ✅ | ✅ |
| Kubernetes HPA ready | ✅ | ✅ | ✅ | ✅ | 🟡 | ✅ | ✅ |
| Multi-region / multi-cluster | 🟡 | 🟡 | ✅ | ✅ | 🟡 | ✅ | 🟡 |
| Distributed rate limiting | ✅ | ✅ | ✅ | 🟡 | ✅ | 🟡 | 🟡 |
| Service mesh (east-west) | ➖ | 🟡 | ➖ | ➖ | ➖ | ✅ | ➖ |
| Memory per node | Low | **Very low** | Low | **Very low** | ❌ High (JVM) | Low | Low |

### Scalability Winner by Scenario

| Scenario | Best choice |
|---|---|
| Maximum throughput per dollar | **KrakenD** (stateless, 70K RPS, zero DB cost) |
| Dynamic config at scale (no restarts) | **Apache APISIX** (etcd, instant propagation) |
| Kubernetes-native auto-scaling | **Envoy Gateway** (xDS, K8s-first design) |
| Multi-region with governance | **Tyk** (hybrid mode, Pump async analytics) |
| Event-driven / async at scale | **Gravitee** (Kafka, MQTT native) |
| Easiest HA setup | **KrakenD** (no DB) or **Traefik** (auto-discover) |

---

## Cost Reality Check

"Free" means free software — not zero operational cost. Self-hosting adds:

- **Infrastructure**: $500–2,000/month for a production-grade cluster
- **Engineering overhead**: 8–16 hours/month for upgrades, patching, monitoring
- **Config store**: PostgreSQL (Kong), etcd (APISIX), MongoDB (Tyk/Gravitee) all need their own HA setup

> **Rule of thumb**: If your managed gateway bill exceeds $2,000/month, evaluate self-hosted. If it's under that, the ops overhead of self-hosting may not be worth it.

---

## Quick Start References

| Gateway | Docker one-liner |
|---|---|
| Kong | `docker run -d --name kong -p 8000:8000 kong/kong-gateway:latest` |
| APISIX | `docker run -d --name apisix -p 9080:9080 apache/apisix:latest` |
| Tyk | `docker run -d --name tyk -p 8080:8080 tykio/tyk-gateway:latest` |
| KrakenD | `docker run -d --name krakend -p 8080:8080 devopsfaith/krakend:latest` |
| Traefik | `docker run -d --name traefik -p 80:80 -p 8080:8080 traefik:latest` |

---

*Last updated: May 2026 · Sections: What is an API Gateway · 7 Gateway Profiles · Feature Comparison · Auth Deep-Dive · Performance Deep-Dive · Scalability Deep-Dive · Decision Guide · Cost Reality Check · Quick Start*  
*Sources: official documentation, published benchmarks, Gartner Peer Insights, CNCF survey data, apisix.apache.org, api7.ai, digitalapi.ai*