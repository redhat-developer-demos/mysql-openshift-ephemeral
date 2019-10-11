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

**NOTE that you must change the user and password values in the following script before running it.**

### Windows
`$PROJECT-HOME/scripts/create-customer.ps1`  

### Linux-based systems (including macOS)
`$PROJECT-HOME/scripts/create-customer.sh`  

## Create the getCustomer service
#### Note: The variables 'MYSQL_USER' and 'MYSQL_PASSWORD' are determined by the values returned after you create the ephemeral MySQL application, above.  

`oc new-app https://github.com/redhat-developer-demos/mysql-openshift-ephemeral.git --context-dir=src/getCustomer --name getcustomer -e MYSQL_HOST=mysql -e MYSQL_DATABASE=sampledb -e MYSQL_USER=userP1F -e MYSQL_PASSWORD=eRwTuVSW1MhsIUHw`  

## Create the getCustomerSummaryList service
#### Note: The variables 'MYSQL_USER' and 'MYSQL_PASSWORD' are determined by the values returned after you create the ephemeral MySQL application, above.  

`oc new-app https://github.com/redhat-developer-demos/mysql-openshift-ephemeral.git --context-dir=src/getCustomerSummaryList --name getcustomersummarylist -e MYSQL_HOST=mysql -e MYSQL_DATABASE=sampledb -e MYSQL_USER=userP1F -e MYSQL_PASSWORD=eRwTuVSW1MhsIUHw`  

## Create the service "mvccustomer"
This will pull a Linux image from a registry. This is being done to demonstrate the versatility of the OpenShift application build feature.

`oc new-app --name mvccustomer --docker-image=quay.io/donschenck/mvccustomer:latest -e GET_CUSTOMER_SUMMARY_LIST_URI="http://getcustomersummarylist:8080/customers" -e GET_CUSTOMER_URI="http://getcustomer:8080/customer"`

## Expose the mvccustomer web site
`oc expose service mvccustomer --insecure-skip-tls-verify=false`

## Test it
Get the route, then open it in your browser:  
`oc get routes`


### END ###