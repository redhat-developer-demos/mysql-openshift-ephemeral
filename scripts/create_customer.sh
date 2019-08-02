mpod=$(oc get pods --selector app=mysql --output name | awk -F/ '{print $NF}')

echo "Copying setup files into pod..."
oc cp ./customer-table-create.sql $mpod:/tmp/customer-table-create.sql
oc cp ./insert-customer-data.sql ${mpod}:/tmp/insert-customer-data.sql

echo "Creating table(s)..."
oc exec $mpod -- bash -c "mysql --user=root sampledb < /tmp/customer-table-create.sql"

echo "Importing data..."
oc exec $mpod -- bash -c "mysql --user=root < /tmp/insert-customer-data.sql"

echo "Here is your table:"
oc exec $mpod -- bash -c "mysql --user=root sampledb -e 'use sampledb; SELECT * FROM customer;'"
