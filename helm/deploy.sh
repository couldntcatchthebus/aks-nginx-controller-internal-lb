# Create a namespace for your ingress resources
kubectl create namespace ingress-internal

# Add the ingress-nginx repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

# Use Helm to deploy an NGINX ingress controller
helm install nginx-ingress ingress-nginx/ingress-nginx \
    --namespace ingress-internal \
    -f internal-ingress.yaml \
    --set controller.replicaCount=2 \
    --set controller.ingressClass=internal \
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set controller.admissionWebhooks.patch.nodeSelector."beta\.kubernetes\.io/os"=linux


# You can watch the status by running 'kubectl --namespace ingress-internal get services -o wide -w nginx-ingress-ingress-nginx-controller'