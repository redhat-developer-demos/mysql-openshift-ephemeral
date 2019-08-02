# Get name of pod running MySQL
$mpod = (oc get pods --selector app=mysql --output name | Select-Object).Split("/")[1]

# Copy setup files to pod
Write-Output 'Copying setup files into pod...'
oc cp .\customer-table-create.sql ${mpod}:/tmp/customer-table-create.sql
oc cp .\insert-customer-data.sql ${mpod}:/tmp/insert-customer-data.sql

# Build table
Write-Output 'Creating table(s)...'
oc exec $mpod -- bash -c "mysql --user=root < /tmp/customer-table-create.sql"

# Populate table
Write-Output 'Importing data...'
oc exec $mpod -- bash -c "mysql --user=root < /tmp/insert-customer-data.sql"

# Prove it all workedZZZZ
Write-Output 'Here is your table:'
oc exec $mpod -- bash -c "mysql --user=root -e 'use sampledb; SELECT * FROM customer;'"