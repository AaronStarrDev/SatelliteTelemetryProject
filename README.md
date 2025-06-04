# SatelliteTelemetryProject
A project that I am doing to help better understand satellite telemetry, and building on it via steps to explore other technologies

---

Uses Google Vision API - Free trial version

---

Google Setup:
1. Setup GCP free trial account
2. In IAM & Admin > Service Accounts > Create Service Account > Viewer permissions (Google Vision API doesn't need much permission) > Set who can use the service account
3. Click on the new service account > Keys > Add Key > should download a key (do not share the key, treat as a password)
4. Download and setup gcloud api
5. gcloud login: ```gcloud auth application-default login```
6. Activate service account with key: ```gcloud auth activate-service-account --key-file="KEYLOCATION.json"```
7. Run script, after getting token from gcloud in script. (Can prob do the api calls with a powershell module provided by Google)