# mysql-openshift-ephemeral
Demo: Creating an ephemeral instance of MySQL in OpenShift

This repository is to accompany a blog post at developers.redhat.com that instructs how to create an ephemeral MySQL instance in OpenShift 4.x. This repo *can* be used standalone, but it really sings when used with the blog post.

Like everything else we do at Red Hat, it's open source and open to pull requests.

## Create an OpenShift instance named "mysql"  
`./openshift-install create cluster`  

## Create a new project
`oc new-project mysql-test`  

## Create MySQL database
`oc new-app mysql-ephemeral --name mysql`  

## Populate database
### Windows
`$PROJECT-HOME/scripts/create-customer.ps1`  

### Linux-based systems
`$PROJECT-HOME/scripts/create-customer.sh`  

## Create the getCustomer service
#### Note: The variables 'MYSQL_USER' and 'MYSQL_PASSWORD' are determined by the values returned after you create the ephemeral MySQL application, above.  

`oc new-app https://github.com/redhat-developer-demos/mysql-openshift-ephemeral.git --context-dir=src/getCustomer --name getcustomer -e MYSQL_HOST=mysql -e MYSQL_DATABASE=sampledb -e MYSQL_USER=userP1F -e MYSQL_PASSWORD=eRwTuVSW1MhsIUHw`  

## Expose the service 'getcustomer'
`oc expose service getcustomer --insecure-skip-tls-verify=false`  

## Test it
`$PROJECT-HOME/src/viewCustomer/index.html`  

### END ###