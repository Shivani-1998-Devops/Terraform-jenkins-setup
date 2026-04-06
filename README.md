- Internet Gateway
- Route Table (Public Access)
- Security Group (Ports 22 & 8080 open)
- EC2 Instance (Amazon Linux 2)
- Jenkins installed via user_data script

---

## 🛠️ Tech Stack

- Terraform
- AWS (EC2, VPC, Networking)
- Jenkins
- Git
- kubectl
- Amazon Linux 2

---

## 📂 Project Structure


.
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
├── backend.tf
├── jenkins-server-script.sh
└── README.md


---

## ⚙️ Prerequisites

Make sure you have:

- AWS Account
- IAM User with proper permissions
- AWS CLI configured:
  ```bash
  aws configure

Terraform installed:

terraform -v
🔐 Important Configuration

Update the following before running:

1. Backend (S3)

Edit backend.tf:

bucket = "your-terraform-state-bucket-file-sssss"

⚠️ Bucket must exist before running Terraform.

2. Key Pair

Ensure this key exists in AWS:

key_name = "linux-key-v"
🚀 Deployment Steps
# Initialize Terraform
terraform init

# Validate config
terraform validate

# Preview changes
terraform plan

# Apply configuration
```bash
terraform apply

Type yes when prompted.

📤 Output

After deployment:

ec2_public_ip = <your-public-ip>
🌐 Access Jenkins

Open in browser:

http://<EC2_PUBLIC_IP>:8080
🔑 Get Jenkins Initial Password

SSH into your instance:

ssh -i linux-key-v.pem ec2-user@<EC2_PUBLIC_IP>

Then run:

sudo cat /var/lib/jenkins/secrets/initialAdminPassword
📦 Installed Tools

Your EC2 instance automatically installs:

Jenkins
Java 17
Git
Terraform
kubectl
🔍 Verification Steps

Check Jenkins status:

sudo systemctl status jenkins

Check installed tools:

java -version
git --version
terraform -version
kubectl version --client
⚠️ Security Notes
Port 8080 is open to the internet → restrict in production
SSH (22) should be limited to your IP
Avoid using default security group in production
🧹 Destroy Infrastructure
terraform destroy
💡 Improvements (Recommended)
Use a custom security group instead of default
Add ALB (Application Load Balancer)
Use HTTPS with ACM
Store secrets in AWS Secrets Manager
Add IAM roles instead of static credentials
```
👨‍💻 Author

shivani 🚀


---

# 🔍 Quick Code Review (Important Fixes)

Your setup is good, but here are **critical improvements**:

### ❗ 1. Avoid Default Security Group
```hcl
aws_default_security_group

👉 Not recommended → create custom aws_security_group

❗ 2. user_data best practice

Wrap script:

#!/bin/bash
set -e
❗ 3. Missing depends_on (optional but safer)
❗ 4. Kubectl path issue

Your current:

export PATH=$PATH:$HOME/bin

👉 This won’t persist. Fix:

echo 'export PATH=$PATH:$HOME/bin' >> /home/ec2-user/.bashrc
❗ 5. Jenkins startup delay

Add:

sleep 30