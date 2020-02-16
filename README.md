make sure kubes context in docker dashboard is docker-desktop

$ kubectl config current-context

## Dashboard.yaml
copied the yaml config [from here](https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml)

$ kubectl apply -f ./dashboard.yaml

## User Account for Token
followed [online guide](https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md)

- $ kubectl apply -f ./dashboard-adminuser.yaml
- $ bash get-token.sh
    - more specific: $ bash get-token.sh | grep token
- copy the "token" for the service user account
- go [here](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login)
- paste in the token

## start the server
$ kubectl proxy


# Kube Koncepts
- pod: one IP per pod, atomic unit of kube
- replication controller (rc): implements "desired" state
    - higher level construct than pods
    - defines your desired state of pods
- service (svc): REST objects, an abstraction, load balancer
    - purpose: reliable endpoint for client that handles connection to individual pods or replication controllers
    - configure labels on service to point to pods
    - ServiceTypes: [ ClusterIP, NodePort, LoadBalancer ]
        ClusterIP: Stable internal cluster IP
        NodePort: Exposes the app outside of the cluster by adding a cluster-wide port on top of ClusterIP
        LoadBalancer: Integrates NodePort with cloud-based load balancers
- endpoint (ep): 
- deployment (deploy): updates & rollbacks
    - replica set (rs): similar to replication controllers
    - deployment commands
        - $ kubectl apply -f tutorial/hello-deploy.yaml --record
        - $ kubectl rollout status deployment hello-deploy
        - $ kubectl rollout history deployment hello-deploy
        - ROLLBACK: get Revision # from previous command 
        - $ kubectl rollout undo deployment hello-deploy --to-revision=1


$ kubectl create -f hello-pod.yaml
$ kubectl delete pods hello-pod
$ kubectl create -f hello-rc.yaml

use $ kubectl apply -f filename.yaml $ when updating yaml file


EASY WAY TO CHECK SELECTOR LABEL
$ kubectl describe pods | grep app