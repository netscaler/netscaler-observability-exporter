kubectl create secret tls ing --cert=ingress.crt --key=ingress.key
kubectl create secret  generic nslogin --from-literal=username='sampleusername' --from-literal=password='samplepassword'
