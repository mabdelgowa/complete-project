# Complete DevOps Project

This repository demonstrates a full DevOps pipeline integrating various tools and technologies to deploy a simple Go application. The application connects to a MySQL database and exposes endpoints for health checks and data retrieval.

## 🛠️ Tools and Technologies

- **Docker & Docker Compose**: Containerization and orchestration of services.
- **Jenkins**: Continuous Integration and Continuous Deployment (CI/CD) automation.
- **Kubernetes**: Container orchestration and management.
- **ArgoCD**: GitOps continuous delivery tool for Kubernetes.
- **Terraform**: Infrastructure as Code (IaC) for provisioning cloud resources. 

## 📂 Project Structure

```

complete-project/
├── .github/workflows/       # GitHub Actions workflows
├── argocd/                  # ArgoCD application manifests
├── auto_scaling_and_secrets/# Kubernetes autoscaling and secrets configurations
├── k8s/                     # Kubernetes manifests
├── terraform/               # Terraform configurations
├── Dockercompose.yaml       # Docker Compose configuration
├── Dockerfile               # Dockerfile for Go application
├── Jenkinsfile              # Jenkins pipeline definition
├── db.go                    # Database connection logic
├── go.mod                   # Go module file
├── go.sum                   # Go dependencies checksum
├── main.go                  # Main application entry point
├── sonar-project.properties # SonarQube configuration
└── README.md                # Project documentation
```


## 🚀 Application Overview

The Go application performs the following:

- **Database Connection**: Connects to a MySQL database using environment variables:
  - `MYSQL_HOST`
  - `MYSQL_USER`
  - `MYSQL_PASS`
  - `MYSQL_PORT`

- **Endpoints**:
  - `GET /`: Retrieves all recorded rows from the database.

The application listens on port `9090`.

## 🐳 Docker & Docker Compose

- **Dockerfile**: Builds the Go application using a lightweight base image (`golang:alpine`) to ensure minimal image size.
- **Dockercompose.yaml**: Defines services for the Go application and MySQL database, facilitating easy local development and testing.

## ⚙️ Jenkins CI/CD Pipeline

- **Jenkinsfile**: Automates the build, test, and deployment processes.
- **Pipeline Stages**:
  - Build the Go application.
  - Run tests to ensure application integrity.
  - Build and push Docker images to a container registry.
  - Deploy the application to a Kubernetes cluster.

## ☸️ Kubernetes Deployment

- **Manifests**: Located in the `k8s/` directory, these define the Kubernetes resources required to deploy the application, including Deployments, Services, and ConfigMaps.
- **Auto Scaling & Secrets**: The `auto_scaling_and_secrets/` directory contains configurations for Horizontal Pod Autoscalers and Kubernetes Secrets to manage sensitive information.

## 🚀 ArgoCD for GitOps

- **ArgoCD Manifests**: The `argocd/` directory contains application definitions for ArgoCD, enabling automated deployment and synchronization of the Kubernetes manifests from the Git repository.

## 🌐 Terraform Infrastructure Provisioning

- **Terraform Configurations**: Located in the `terraform/` directory, these scripts provision the necessary cloud infrastructure, such as Kubernetes clusters and networking components, ensuring a consistent and reproducible environment.

## 🔍 Code Quality with SonarQube

- **SonarQube Configuration**: The `sonar-project.properties` file sets up the integration with SonarQube to analyze code quality, detect bugs, and ensure maintainability.

## 📝 Getting Started

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/mabdelgowa/complete-project.git
   cd complete-project
   ```


2. **Set Environment Variables**:
   Ensure the following environment variables are set for database connectivity:
   - `MYSQL_HOST`
   - `MYSQL_USER`
   - `MYSQL_PASS`
   - `MYSQL_PORT`

3. **Build and Run with Docker Compose**:
   ```bash
   docker-compose up --build
   ```


4. **Access the Application**:
   - Data Retrieval: [http://localhost:9090/](http://localhost:9090/)

## 🤝 Contributing

Contributions are welcome! Please fork the repository and submit a pull request for any enhancements or bug fixes.

## 📧 Contact

For questions or support, please open an issue on the [GitHub repository](https://github.com/mabdelgowa/complete-project/issues).

---

This `README.md` provides a clear overview and instructions for using the complete DevOps project, facilitating deployment and management of the Go application using modern DevOps tools and practices. 
