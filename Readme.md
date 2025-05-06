### 1. This defines a trusted identity pool for GitHub.

```
gcloud iam workload-identity-pools create "github-pool" \
--location="global" \
--display-name="GitHub Actions Pool"
```

Creates a pool named github-pool


### 2. Create a Provider inside the Pool

This provider trusts GitHub's OIDC tokens.

```
 gcloud iam workload-identity-pools providers create-oidc "github-provider" \
  --location="global" \
  --workload-identity-pool="github-pool" \
  --display-name="GitHub Provider" \
  --issuer-uri="https://token.actions.githubusercontent.com" \
  --attribute-mapping="google.subject=assertion.sub,attribute.repository=assertion.repository" \
  --attribute-condition="attribute.repository=='javed-shaikh-devops/db-snr'"
```

Key parts:

issuer-uri: GitHub’s official OIDC endpoint

attribute-mapping: maps GitHub claims to GCP attributes.
### 2.1 Create SA 
gcloud iam service-accounts create terraform-deployer \
--description="Terraform deployer account for GitHub Actions WIF" \
--display-name="Terraform Deployer" \
--project=db-demo-458921


### 3. Allow Your GitHub Repository Access (Condition)

You restrict access to specific GitHub repositories (important for security).

Example:

```
gcloud iam service-accounts add-iam-policy-binding "terraform-deployer@YOUR_PROJECT_ID.iam.gserviceaccount.com" \
--role="roles/iam.workloadIdentityUser" \
--member="principalSet://iam.googleapis.com/projects/YOUR_PROJECT_NUMBER/locations/global/workloadIdentityPools/github-pool/attribute.repository/YOUR_GITHUB_ORG/YOUR_REPO"
```

Replace:

terraform-deployer@YOUR_PROJECT_ID.iam.gserviceaccount.com → your Service Account email

YOUR_PROJECT_ID → your GCP project

YOUR_PROJECT_NUMBER → your GCP numeric project ID

YOUR_GITHUB_ORG/YOUR_REPO → e.g., myorg/myrepo


### 4. Get the Provider Resource Name

You need this for GitHub Secrets.

Command:
```
gcloud iam workload-identity-pools providers describe "github-provider" \
--location="global" \
--workload-identity-pool="github-pool" \
--format="value(name)"
```

### 5. Add GitHub Secrets
 GCP_WORKLOAD_IDENTITY_PROVIDER
 GCP_SERVICE_ACCOUNT_EMAIL



### Wofklow
GitHub Actions OIDC Token
            |
            V   
GCP Workload Identity Pool
            |
            V
Workload Identity Provider (trusts GitHub OIDC)
            |
            V
GCP Service Account (impersonation rights)
            |
            V
Terraform authenticated to GCP


# 📚 README.md

# Terraform GCP Deployment with GitHub Actions and Workload Identity Federation (WIF)

---

## Overview

This repository demonstrates a **secure and production-ready** setup to deploy Terraform-managed infrastructure to **Google Cloud Platform (GCP)** using **GitHub Actions** and **Workload Identity Federation (WIF)**.

✅ No static credentials  
✅ Plan → Manual Approval → Apply  
✅ Full auditability and safety

---

## Repository Structure

