# LMS EKS Deployment

## Create EKS cluster and add Nodegroup

- Login to aws and goto EKS section
- Now click on create cluster
- Give a proper cluster name: lms-cluster
- Select IAM role if you don’t have create one

### Click on create role 
- Select EKS cluster related policies
- Now goto your configuration and select created role
- Configure cluster
- Insert your role here

- Specify networking

- Configure logging

- Select add-ons
  - Core DNS
  - Kube-proxy
  - Amazon VPC CNI

- Configure selected add-ons
- Review and create
- Check your created cluster it will take few minutes to create

## Adding NodeGroup

### Once cluster created add Nodegroup to it

- Create Node group
  - goto your cluster - compute - add node group
     - Create node group role 
        - EC2
          - AmazonEKSWorkerNodePolicy
          - AmazonEC2ContainerRegistryReadOnly
          - AmazonEKS_CNI_Policy

- Goto your cluster
- Select: compute - add node group
- Configure node group
- Name: lms-nodegroup
- Add IAM role: amazoneksnoderole


- Set compute and scaling configuration
- node group  compute config
  - select ami: Amazon linux 2
  - instance type: t3.medium
  - disk size of node: 20 gb
- node group scaling config
  - desired:2
  - max:2
  - min:2
- node group update config
 - number : 1
- Specify networking
- Node group network configuration
- Select subnets: 2

- Review and create
- Wait few minutes for creation of nodes


## Launch k8s Workstation and connect it to EKS cluster
 - Os: ubuntu 20.0
 - T2.medium
 - Ports: 22, 80, 443 ( open all traffic )
 - Repo: git clone https://github.com/muralialakuntla3/k8s-hpa.git

### Install aws cli
- aws cli install 
  - sudo apt  install awscli -y
  - aws --version
  - aws s3 ls

### Install Kubectl:
  - kubectl version
  - curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl
  - chmod +x kubectl
  - sudo mv kubectl /usr/local/bin/kubectl
  - kubectl version

### Install Docker:
 - visit: https://get.docker.com/
 - curl -fsSL https://get.docker.com -o install-docker.sh
 - sudo sh install-docker.s
 - sudo usermod -aG docker ubuntu

### Configure aws cli :

- Create Access key and Secret key
- Generate access key and secret key in aws
- Goto IAM > Security credentials
- Create access key
- Copy access key and secret key

- aws configure
- AWS Access Key ID [None]: *************
- AWS Secret Access Key [None]: *****************
- Default region name [None]: ap-south-1
- Default output format [None]: json
- aws sts get-caller-identity
- aws s3 ls

## Adding Workstation to EKS cluster:
- Now goto your EKS cluster in aws
- Goto your cluster Security Group
- Add your Workstation pvt-ip or add vpc cidr

## Now goto your Workstation
- aws eks list-clusters   ------- to list the cluster

### Connecting clutter to workstation:
- aws eks update-kubeconfig --name <cluster name> --region <region name>
- cat ~/.kube/config    ------- to get cluster info

## Deploy application
- kubectl get all
- kubectl get nodes

### Database
- cd ~/lms/k8s
- kubectl apply -f pg-secret.yml
- kubectl apply -f pg-deployment.yml
- kubectl apply -f pg-service.yml

### Backend
- build and push docker image
- kubectl apply -f be-configmap.yml
- kubectl apply -f be-deployment.yml
- kubectl apply -f be-service.yml

### Frontend
- build and push dokcer image with new backend url
- kubectl apply -f fe-deployment.yml
- kubectl apply -f fe-service.yml
- kubectl get all

## Delete resources once lab done
- delete the nodegroup
- delete eks cluster
- delete roles
- delete workstation

