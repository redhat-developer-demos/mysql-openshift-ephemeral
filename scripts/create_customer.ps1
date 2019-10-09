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

# Prove it all worked
Write-Output 'Here is your table:'
oc exec $mpod -- bash -c "mysql --user=root -e 'use sampledb; SELECT * FROM customer;'"

# Temporary fix because MySQL 8.* client isn't secure in mysqljs Nodejs module
Write-Output 'Setting user password...'
oc exec $mpod -- bash -c "mysql --user=root -e 'ALTER USER '\''userJTT'\'' IDENTIFIED WITH mysql_native_password BY '\''waqtujG4tV4YePix'\'';'"

Write-Output 'Flushing privileges...'
oc exec $mpod -- bash -c "mysql --user=root -e 'FLUSH PRIVILEGES;'"