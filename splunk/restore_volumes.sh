docker run --rm --volumes-from arrowpoint-telemetry_splunkenterprise_1 -v $(pwd):/backup ubuntu bash -c "cd /opt/splunk/etc && tar xvf /backup/etc.tar --strip 3"
docker run --rm --volumes-from arrowpoint-telemetry_splunkenterprise_1 -v $(pwd):/backup ubuntu bash -c "cd /opt/splunk/var && tar xvf /backup/var.tar --strip 3"