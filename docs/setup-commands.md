1. Workload Identity Pool 
bashgcloud iam workload-identity-pools create "github-pool" \
  --project="gcp-devops-project-496602" \
  --location="global" \
  --display-name="GitHub Actions Pool"

2. OIDC Provider 
bashgcloud iam workload-identity-pools providers update-oidc "github-provider" \
  --project="gcp-devops-project-496602" \
  --location="global" \
  --workload-identity-pool="github-pool" \
  --attribute-mapping="google.subject=assertion.sub,attribute.repository=assertion.repository,attribute.actor=assertion.actor,attribute.repository_owner=assertion.repository_owner" \
  --attribute-condition="assertion.repository=='apingale2026/gke-ecommerce-app'" \
  --issuer-uri="https://token.actions.githubusercontent.com"

3. Service Account 
bashgcloud iam service-accounts create "github-actions-sa" \
  --project="gcp-devops-project-496602" \
  --display-name="GitHub Actions SA"

4. Grant Permissions 
bash# Artifact Registry write
gcloud projects add-iam-policy-binding gcp-devops-project-496602 \
  --member="serviceAccount:github-actions-sa@gcp-devops-project-496602.iam.gserviceaccount.com" \
  --role="roles/artifactregistry.writer"

# GKE deploy
gcloud projects add-iam-policy-binding gcp-devops-project-496602 \
  --member="serviceAccount:github-actions-sa@gcp-devops-project-496602.iam.gserviceaccount.com" \
  --role="roles/container.developer"

5. Bind GitHub repo to SA 
bashgcloud iam service-accounts add-iam-policy-binding \
  "github-actions-sa@gcp-devops-project-496602.iam.gserviceaccount.com" \
  --project="gcp-devops-project-496602" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/136499647961/locations/global/workloadIdentityPools/github-pool/attribute.repository/apingale2026/gke-ecommerce-app"

6. GitHub Actions deploy.yml 
Key values used:
yamlWIF_PROVIDER: projects/136499647961/locations/global/workloadIdentityPools/github-pool/providers/github-provider
WIF_SA: github-actions-sa@gcp-devops-project-496602.iam.gserviceaccount.com
PROJECT_ID: gcp-devops-project-496602
REGION: asia-south1
REGISTRY: asia-south1-docker.pkg.dev
REPOSITORY: gcp-devops-project-496602-dev-repo
GKE_CLUSTER: gcp-devops-project-496602-dev-gke