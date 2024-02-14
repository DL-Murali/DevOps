# EKS Cluster

- create EKS cluster
  - create EKS cluster role
    - EKS
      - next

- Create Node group
  - goto your cluster - compute - add node group
     - Create node group role 
        - EC2
          - AmazonEKSWorkerNodePolicy
          - AmazonEC2ContainerRegistryReadOnly
          - AmazonEKS_CNI_Policy

- Launch Work Station

  - sudo apt update

- aws cli install & aws configuration

  - sudo apt  install awscli -y
  - aws --version
  - aws s3 ls
  - aws configure
  - aws eks list-clusters

- kubectl install

  - kubectl version
  - curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl
  - chmod +x kubectl
  - sudo mv kubectl /usr/local/bin/kubectl
  - kubectl version

  - aws eks list-clusters
  - aws eks update-kubeconfig --name lms-cluster --region us-west-1
  - cat /home/ubuntu/.kube/config

- update workstation pvt-ip in eks-cluster-security group

  - kubectl get all

