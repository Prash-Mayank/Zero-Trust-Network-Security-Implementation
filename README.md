# Zero Trust Network Security Implementation

**Project ID:** BT0231  
**University:** Galgotias University  
**Academic year:** 2026–2027  
**Project guide:** Mr. Manish Pandey  
**Team:** Aman Dixit and Mayank Prashar

A capstone project to design and develop a small, testable Zero Trust access-control prototype. The project applies identity-based authentication, policy-driven authorization, least privilege, default-deny access and audit logging to requests for protected resources.

> **Project status:**
> Phase 1 :- Identity Provider Setup — completed and validated. Subsequent gateway, policy-enforcement and protected-resource phases are planned/in progress.

## 1. Project objective

The objective is to demonstrate how access to protected resources can be controlled by verifying identity and evaluating authorization policy for each request, rather than trusting a user or device solely because it is connected to an internal network.

The prototype is intended for academic demonstration and experimentation. It is not a production-ready enterprise Zero Trust deployment.

## 2. Current implementation status

### Phase 1 :— Identity Provider Setup: PASS

Keycloak is configured as the identity provider for the `zerotrust` realm, with PostgreSQL as its backing database.

The Phase 1 token inspection verified the following claims:

| Claim / property     | Verified observation                                |
| -------------------- | --------------------------------------------------- |
| `iss`                | Identifies the `zerotrust` realm issuer             |
| `realm_access.roles` | Contains the `USER` role for the tested user        |
| `iat` and `exp`      | Difference is 300 seconds (5-minute token lifetime) |
| `jti`                | Present as a unique token identifier                |

### Planned development phases

| Component / phase  | Purpose                                              | Status             |
| ------------------ | ---------------------------------------------------- | ------------------ |
| Identity provider  | Keycloak realm, users, roles and token issuance      | **Phase 1 passed** |
| Protected services | Sample resources that require authorization          | Planned            |
| Gateway            | Entry point for client requests and token validation | Planned            |
| Policy service     | Centralized access-policy evaluation                 | Planned            |
| Baseline           | Login-only comparison implementation                 | Planned            |
| Attack scenarios   | Test unauthorized access and security weaknesses     | Planned            |
| Load tests         | Measure response time and behaviour under load       | Planned            |
| Documentation      | Architecture, test evidence and results              | In progress        |

## 3. Architecture and technologies

| Technology         | Role in the project                                                     |
| ------------------ | ----------------------------------------------------------------------- |
| Keycloak           | Identity provider and OpenID Connect token issuer                       |
| PostgreSQL         | Keycloak persistence                                                    |
| Docker Compose     | Local orchestration of the identity-provider stack                      |
| Java / Spring Boot | Planned application services and access-control components              |
| Spring Security    | Planned authentication and authorization integration                    |
| MySQL              | Planned application data store, if retained in the final service design |
| Postman / curl     | API and token-flow testing                                              |
| Git and GitHub     | Source control and project collaboration                                |

## 4. Repository structure

```text
zero-trust-project/
├── docker-compose.yml       # Keycloak + PostgreSQL
├── keycloak/
│   └── zerotrust-realm.json # Realm, client and role configuration
├── scripts/
│   └── get-token.sh         # Local token helper
├── gateway/                 # Planned gateway component
├── policy-service/          # Planned policy evaluation component
├── service-1/               # Planned protected resource
├── service-2/               # Planned protected resource
├── service-3/               # Planned protected resource
├── baseline/                # Planned baseline implementation
├── attacks/                 # Planned security test scenarios
├── loadtests/               # Planned performance tests
├── docs/                    # Diagrams, test evidence and notes
├── .env.example             # Placeholder environment configuration
└── README.md
```

## 5. Run the identity-provider environment locally

### Prerequisites

- Docker Desktop with Docker Compose
- Git
- `curl`
- Python 3 (used by the token helper to decode token claims)

### Configure local environment variables

Copy the example file:

```bash
cp .env.example .env
```

On Windows PowerShell:

```powershell
Copy-Item .env.example .env
```

Edit `.env` locally and set your own database and Keycloak bootstrap-admin credentials.

### Start the containers

```bash
docker compose up -d
```

Check container status:

```bash
docker compose ps
```

Follow Keycloak logs:

```bash
docker compose logs -f keycloak
```

The local Keycloak endpoint is:

```text
http://localhost:8081
```

The `zerotrust` realm is imported from `keycloak/zerotrust-realm.json`.

## 6. Phase 1 validation

The Phase 1 validation covered:

1. Obtaining an access token from the `zerotrust` realm.
2. Inspecting the token issuer (`iss`).
3. Confirming the expected role in `realm_access.roles`.
4. Checking the token lifetime using `iat` and `exp`.
5. Confirming the presence of a unique `jti` claim.

The observed token lifetime was five minutes.

## 7. Next development objectives

The next implementation work is to:

1. Create the protected resource services.
2. Implement a gateway that validates incoming access tokens.
3. Integrate the gateway with a policy service.
4. Enforce role- and policy-based access decisions for each protected resource.
5. Add audit logging for allowed and denied requests.
6. Test valid tokens, missing tokens, expired tokens, insufficient roles and unauthorized resource access.
7. Build a login-only baseline for comparison.
8. Run documented attack scenarios and load tests.
9. Record evidence, limitations and measured results in the final report.

## 8. Project principle

**Never trust, always verify.** Every request to a protected resource should be authenticated and evaluated against an explicit access policy. A successful login alone must not imply unrestricted access to every service.
