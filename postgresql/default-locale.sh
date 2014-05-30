pg_ctlcluster --force 9.3 main stop
pg_dropcluster 9.3 main
pg_createcluster --start -e UTF-8 9.3 main
