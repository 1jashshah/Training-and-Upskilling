#!/bin/bash

# ------------------------------
# Variables
# ------------------------------
CLUSTER_NAME="eksclusterofmyapp2"
REGION="ap-south-1"
NODEGROUP_NAME="ng-public2"       # Use a fresh name to avoid conflicts
NODE_TYPE="t3.medium"
NODES=2
SSH_KEY="linux"                    # Make sure this key exists in EC2 keypairs
ZONES="ap-south-1a,ap-south-1b"

# ------------------------------
# Step 1: Create EKS Cluster without Nodegroup
# ------------------------------
eksctl create cluster \
  --name $CLUSTER_NAME \
  --region $REGION \
  --zones $ZONES \
  --without-nodegroup

# ------------------------------
# Step 2: List clusters to confirm creation
# ------------------------------
eksctl get cluster --region $REGION

# ------------------------------
# Step 3: Associate IAM OIDC provider for IRSA
# ------------------------------
eksctl utils associate-iam-oidc-provider \
  --region $REGION \
  --cluster $CLUSTER_NAME \
  --approve

# ------------------------------
# Step 4: Verify EC2 key exists, create if missing
# ------------------------------
if ! aws ec2 describe-key-pairs --region $REGION --query "KeyPairs[?KeyName=='$SSH_KEY']" | grep -q $SSH_KEY; then
  echo "EC2 Keypair '$SSH_KEY' not found. Creating..."
  aws ec2 create-key-pair --key-name $SSH_KEY --query 'KeyMaterial' --output text > ${SSH_KEY}.pem
  chmod 400 ${SSH_KEY}.pem
fi

# ------------------------------
# Step 5: Create Managed Nodegroup
# ------------------------------
eksctl create nodegroup \
  --cluster $CLUSTER_NAME \
  --region $REGION \
  --name $NODEGROUP_NAME \
  --node-type $NODE_TYPE \
  --nodes $NODES \
  --nodes-min $NODES \
  --nodes-max 4 \
  --node-volume-size 20 \
  --ssh-access \
  --ssh-public-key $SSH_KEY \
  --managed \
  --asg-access \
  --external-dns-access \
  --full-ecr-access \
  --appmesh-access \
  --alb-ingress-access

# ------------------------------
# Step 6: Wait for Nodes to Join
# ------------------------------
echo "Waiting for nodes to join the cluster..."
while true; do
    NODES_READY=$(kubectl get nodes --no-headers 2>/dev/null | grep -c "Ready")
    if [[ $NODES_READY -ge $NODES ]]; then
        echo "All $NODES nodes are Ready!"
        kubectl get nodes
        break
    else
        echo "Nodes not ready yet. Checking again in 30 seconds..."
        sleep 30
    fi
done
