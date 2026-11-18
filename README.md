# Zero Trust Network Security Implementation

<<<<<<< HEAD
**Project ID:** BT0231
**University:** Galgotias University
**Academic year:** 2026–2027
**Project guide:** Mr. Manish Pandey
**Team:** Aman Dixit and Mayank Prashar

A capstone project to design and develop a small, testable Zero Trust access-control prototype. The project applies identity-based authentication, policy-driven authorization, least privilege, default-deny access and audit logging to requests for protected resources.

> **Project status:** Phase 1 — Identity Provider Setup — completed and validated. Subsequent gateway, policy-enforcement and protected-resource phases are planned/in progress. Do not treat planned components as implemented until their tests pass.

## 1. Project objective

The objective is to demonstrate how access to protected resources can be controlled by verifying identity and evaluating authorization policy for each request, rather than trusting a user or device solely because it is connected to an internal network.

The prototype is intended for academic demonstration and experimentation. It is not a production-ready enterprise Zero Trust deployment.

## 2. Current implementation status

### Phase 1 — Identity Provider Setup: PASS

Keycloak is configured as the identity provider for the `zerotrust` realm, with PostgreSQL as its backing database.

The Phase 1 token inspection verified the following claims:

| Claim / property | Verified observation |
|---|---|
| `iss` | Identifies the `zerotrust` realm issuer |
| `realm_access.roles` | Contains the `USER` role for the tested user |
| `iat` and `exp` | Difference is 300 seconds (5-minute token lifetime) |
| `jti` | Present as a unique token identifier |

These checks confirm the expected identity and token metadata for the tested account. They do not, by themselves, prove that downstream services enforce authorization correctly; that will be tested in later phases.

### Planned development phases

| Component / phase | Purpose | Status |
|---|---|---|
| Identity provider | Keycloak realm, users, roles and token issuance | **Phase 1 passed** |
| Protected services | Sample resources that require authorization | Planned |
| Gateway | Entry point for client requests and token validation | Planned |
| Policy service | Centralized access-policy evaluation | Planned |
| Baseline | Login-only comparison implementation | Planned |
| Attack scenarios | Test unauthorized access and security weaknesses | Planned |
| Load tests | Measure response time and behaviour under load | Planned |
| Documentation | Architecture, test evidence and results | In progress |

## 3. Architecture and technologies

| Technology | Role in the project |
|---|---|
| Keycloak | Identity provider and OpenID Connect token issuer |
| PostgreSQL | Keycloak persistence |
| Docker Compose | Local orchestration of the identity-provider stack |
| Java / Spring Boot | Planned application services and access-control components |
| Spring Security | Planned authentication and authorization integration |
| MySQL | Planned application data store, if retained in the final service design |
| Postman / curl | API and token-flow testing |
| Git and GitHub | Source control and project collaboration |

The current Docker Compose stack starts Keycloak and PostgreSQL. The application-service components are separate development work and should not be described as already running.

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

Edit `.env` locally and set your own database and Keycloak bootstrap-admin credentials. Do not paste credentials into this README, source files, screenshots, issues or commits.

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

### Configure development users

For a clean repository, the realm import does not contain user passwords. Set local development passwords through the Keycloak Admin Console after the realm has been imported. Configure the administrator's required TOTP action in Keycloak before testing an MFA-protected login.

Do not commit exported realm files containing real credentials, tokens, client secrets or other sensitive values.

## 6. Phase 1 validation

The Phase 1 validation covered:

1. Obtaining an access token from the `zerotrust` realm.
2. Inspecting the token issuer (`iss`).
3. Confirming the expected role in `realm_access.roles`.
4. Checking the token lifetime using `iat` and `exp`.
5. Confirming the presence of a unique `jti` claim.

The observed token lifetime was five minutes. Access tokens are bearer credentials: do not publish, commit, or share complete token strings. When sharing evidence, show only the necessary decoded claims and redact personal or sensitive values.

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

Each phase should be marked complete only after its implementation and corresponding tests have been run and recorded.

## 8. Security and repository hygiene

- `.env` contains local secrets and must never be committed.
- `.env.example` must contain placeholders only, never real credentials.
- Do not commit passwords, access tokens, refresh tokens, private keys, client secrets or database dumps.
- Do not put passwords directly into README commands, screenshots or issue reports.
- Review staged files before every commit:

```bash
git status
git diff --cached
```

- If a secret was ever committed or pushed, removing it from the latest file is not sufficient. Rotate the affected credential and clean the repository history as appropriate.
- Local `start-dev` mode and HTTP are for development only, not production.

## 9. Project principle

**Never trust, always verify.** Every request to a protected resource should be authenticated and evaluated against an explicit access policy. A successful login alone must not imply unrestricted access to every service.
=======
A research-oriented project focused on implementing and evaluating a Zero Trust Network Security approach for secure access to applications and resources.

## Project Overview

Traditional network security models often rely on perimeter-based security, where users or devices inside the network may receive a certain level of implicit trust.

This project explores the Zero Trust security model based on the principle of:

> **Never Trust, Always Verify**

The proposed system will continuously verify users and access requests, apply least-privilege access policies, and maintain security logs to evaluate unauthorized access attempts and security performance.

## Objectives

- Study the principles and architecture of Zero Trust Network Security.
- Analyze the limitations of traditional perimeter-based security.
- Implement identity-based authentication and authorization.
- Apply Role-Based Access Control (RBAC) and least-privilege principles.
- Implement continuous verification of access requests.
- Record and analyze authentication and authorization events.
- Simulate unauthorized access attempts.
- Evaluate security improvements and performance overhead.

## Research Focus

The research will focus on the following areas:

- Zero Trust Architecture (ZTA)
- Identity and Access Management (IAM)
- Continuous Authentication and Authorization
- Least Privilege Access
- Role-Based Access Control (RBAC)
- Access Policy Enforcement
- Security Monitoring and Audit Logs
- Unauthorized Access Detection
- Security vs. Performance Trade-offs

## Proposed Technology Stack

| Component | Technology |
|---|---|
| Backend | Java, Spring Boot |
| Security | Spring Security, JWT |
| Identity Management | Keycloak |
| API Gateway | NGINX |
| Database | MySQL |
| Containerization | Docker |
| API Testing | Postman |
| Performance Testing | JMeter / k6 |
| Monitoring | Prometheus, Grafana |
| Version Control | Git, GitHub |

## Proposed Architecture

The system will follow a Zero Trust access flow:

```text
User / Device
      |
      v
Identity Verification
      |
      v
Authentication
      |
      v
Access Policy Evaluation
      |
      v
Authorization
      |
      v
Protected Resource
      |
      v
Audit Logs & Monitoring
```

Access will be granted based on identity, role, permissions, and security policies rather than simply trusting the user's network location.

## Research Evaluation

The implementation will be evaluated using controlled experiments such as:

- Authorized vs. unauthorized access attempts
- Role-based access violations
- Repeated authentication requests
- Policy enforcement effectiveness
- Authentication and authorization latency
- Request response time
- System overhead
- Security event and audit-log analysis

## Research Questions

1. How can Zero Trust principles be implemented in a small-scale application environment?
2. How does continuous verification improve access control compared with traditional implicit-trust approaches?
3. How effectively can least-privilege policies prevent unauthorized access?
4. What performance overhead is introduced by additional security verification?
5. What practical challenges arise when implementing Zero Trust security?

## Repository Structure

```text
Zero-Trust-Network-Security-Implementation/
│
├── research/
│   ├── papers/
│   ├── literature-review.md
│   ├── research-gap.md
│   └── references.md
│
├── implementation/
│   └── README.md
│
└── README.md
```

## Project Status

### Research

- [x] Project topic finalized
- [x] GitHub repository created
- [ ] Research papers collection
- [ ] Literature review
- [ ] Research gap identification
- [ ] Abstract
- [ ] Introduction

### Implementation

- [ ] System architecture
- [ ] Authentication
- [ ] Authorization
- [ ] Access policies
- [ ] Audit logging
- [ ] Security testing
- [ ] Performance evaluation
- [ ] Monitoring

### Research Paper

- [ ] Methodology
- [ ] Experimental results
- [ ] Analysis
- [ ] Conclusion
- [ ] Final paper

## Project Information

**Project Title:** Zero Trust Network Security Implementation

**Project ID:** BT0231

**Project Type:** App Development / Utility

**Project Outcome:** Project and Research Paper

**SDG Goal:** 9

**Publication Target:** SCOPUS Conference

**Guide:** Mr. Manish Pandey

**Students:**

- Aman Dixit
- Mayank Prashar

---

> This repository is being developed as part of the B.Tech Capstone Project-I and Project-II.
>>>>>>> origin/main
