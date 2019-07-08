mpod=$(oc get pods --selector app=mysql --output name | awk -F/ '{print $NF}')

echo "Copying setup files into pod..."
oc cp ./customer-table-create.sql $mpod:/tmp/customer-table-create.sql
oc cp ./customer-data.txt $mpod:/tmp/customer-data.txt

echo "Creating table(s)..."
oc exec $mpod -- bash -c "mysql --user=root sampledb < /tmp/customer-table-create.sql"

echo "Importing data..."
oc exec $mpod -- bash -c "mysql --user=root sampledb -e 'use sampledb; LOAD DATA LOCAL INFILE \"/tmp/customer-data.txt\" INTO TABLE customer FIELDS TERMINATED BY \",\" ENCLOSED BY \"""\" LINES TERMINATED BY '\'\\\n\'' IGNORE 1 ROWS (customerName,effectiveDate,description,status);'"

echo "Here is your table:"
oc exec $mpod -- bash -c "mysql --user=root sampledb -e 'use sampledb; SELECT * FROM customer;'"
