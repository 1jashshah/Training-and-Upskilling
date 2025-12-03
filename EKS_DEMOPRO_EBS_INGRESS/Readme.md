# EKS Ingress, ALB, Target Groups, and Persistent Storage Guide

## Overview

This guide explains AWS EKS ingress concepts, ALB usage, target groups,
path/host-based routing, service types, and Kubernetes Persistent
Volumes (PV), Persistent Volume Claims (PVC), and StorageClasses. It
also includes commands for deploying pods and storage resources.

------------------------------------------------------------------------

## When You Need Ingress

### 1. Multiple Services Under the Same Domain

Example: - `/` → frontend service - `/api` → backend service

Instead of creating separate LoadBalancers, Ingress handles traffic
routing at the path level.

### 2. Host-Based Routing

Example: - `frontend.example.com` → frontend service\
- `api.example.com` → backend service

### 3. TLS/HTTPS Termination

Ingress allows SSL termination at the ALB level.\
Without Ingress, every LoadBalancer or pod would need its own
certificates.

------------------------------------------------------------------------

## When You Do Not Need Ingress

-   Only one service requires external access → use LoadBalancer.
-   Internal-only microservices → use ClusterIP.
-   Local testing → `kubectl port-forward` or NodePort.

------------------------------------------------------------------------

## AWS ALB Ingress

### What ALB Ingress Controller Does

When an Ingress resource is applied: - It creates an ALB. - It creates
Target Groups for each backend service. - It configures listeners and
routes. - It manages health checks automatically.

### Target Group Mapping Example

  Path     Service    Target Group
  -------- ---------- --------------
  `/`      frontend   tg-frontend
  `/api`   backend    tg-backend

------------------------------------------------------------------------

## Target Types

### Target Types in ALB Target Groups

  -------------------------------------------------------------------------
  Target Type                Meaning            Flow         Notes
  -------------------------- ------------------ ------------ --------------
  instance                   Targets EC2        ALB →        Requires
                             instances          NodePort →   NodePort
                                                Pod          

  ip                         Targets Pod IPs    ALB → Pod    Recommended,
                                                             fast, no
                                                             NodePort
                                                             needed
  -------------------------------------------------------------------------

### When to Use Target Type = ip

-   Default and recommended for EKS.
-   Pads get traffic directly.
-   Works with ClusterIP service.

### When to Use Target Type = instance

-   ALB sends to EC2 nodes.
-   Requires NodePort service.
-   Useful for legacy or node-level inspection.

------------------------------------------------------------------------

## Internal vs Internet-Facing ALB

-   **Internal ALB**: Accessible only inside VPC.
-   **Public ALB**: Exposed to internet, used for public websites.

------------------------------------------------------------------------

## Persistent Storage in Kubernetes (PV, PVC, StorageClass)

### Persistent Volume (PV)

A cluster-level storage resource---EBS, EFS, NFS, etc.

### Persistent Volume Claim (PVC)

A request for storage by a pod.

### StorageClass

Defines: - Provisioner (e.g., EBS CSI driver) - Volume type\
- Reclaim policy\
- Binding mode

Dynamic provisioning happens through StorageClass → PVC → PV.

------------------------------------------------------------------------

## EBS on EKS

### Requirements

-   EBS CSI Driver must be installed.
-   StorageClass must exist.
-   PVC must request storage.
-   Pods mount PVC as volume.

### EBS Deployment Example

#### StorageClass

``` yaml
apiVersion: storage.k8s.io/v1
kind:StorageClass
metadata:
  name: ebs-sc
provisioner: ebs.csi.aws.com
volumeBindingMode: WaitForFirstConsumer
parameters:
  type: gp3
```

#### PVC

``` yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: ebs-claim
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
  storageClassName: ebs-sc
```

#### Pod Mounting EBS PVC

``` yaml
apiVersion: v1
kind: Pod
metadata:
  name: ebs-test
spec:
  containers:
  - name: app
    image: nginx
    volumeMounts:
    - mountPath: "/data"
      name: ebs-volume
  volumes:
  - name: ebs-volume
    persistentVolumeClaim:
      claimName: ebs-claim
```

------------------------------------------------------------------------

## EFS on EKS

### When to Use EFS

-   Shared storage across multiple pods.
-   ReadWriteMany required.

### Example PVC + StorageClass for EFS

``` yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: efs-sc
provisioner: efs.csi.aws.com
```

``` yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: efs-claim
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 5Gi
  storageClassName: efs-sc
```

------------------------------------------------------------------------

## Basic Commands

### Pod

``` sh
kubectl get pods
kubectl describe pod <name>
kubectl logs <pod>
kubectl exec -it <pod> -- /bin/bash
kubectl run <pod-name> --image=<image-name> 
```

### Services

``` sh
kubectl get svc
kubectl describe svc <name>
```

### Deployments

``` sh
kubectl apply -f deployment.yaml
kubectl rollout status deploy/<name>
kubectl rollout restart deploy/<name>
kubectl create deployment <deployment-name> --image=<image-name> --replicas=<number-of-replicas> --port=<container-port>
```
roll out:
the process of gradually updating an application or its configuration by creating a new version of its Pods while the old ones are still running.
### Ingress

``` sh
kubectl get ingress
kubectl describe ingress <name>
```

### Storage

``` sh
kubectl get pv
kubectl get pvc
kubectl describe pvc <name>
```

### Logs commands
```bash
kubectl logs <pod-name>
real time--     kubectl logs -f <pod-name>
```

------------------------------------------------------------------------

## Example ALB Ingress for Frontend and Backend

``` yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: app-ingress
  annotations:
    kubernetes.io/ingress.class: alb
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: ip
spec:
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: frontend-svc
            port:
              number: 80
      - path: /api
        pathType: Prefix
        backend:
          service:
            name: backend-svc
            port:
              number: 80
```

------------------------------------------------------------------------

## Conclusion

-   Use LoadBalancer for simple apps.
-   Use Ingress for routing, TLS, multiple services.
-   Use `target-type: ip` for modern EKS setups.
-   Use PV/PVC for storage; EBS for single pod, EFS for shared storage.
-   while using EBS we just need to create PVC not PV but while using the EFS we have to create PV & PVC.