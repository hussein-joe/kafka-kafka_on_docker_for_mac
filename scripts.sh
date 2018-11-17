docker run -d --name pause_container \
    -p 9092:9092 \
    -p 2181:2181 \
    gcr.io/google_containers/pause-amd64:3.0

docker exec kafka kafka-topics --zookeeper localhost:2181 --create --topic test --partitions 1 --replication-factor 1

docker exec -it kafka kafka-console-producer --broker-list localhost:9092 --topic test
docker exec -it kafka kafka-console-consumer --bootstrap-server localhost:9092 --topic test --from-beginning

docker run -it --net=container:pause_container --ipc=container:pause_container \
--pid=container:pause_container     confluentinc/cp-kafka:5.0.0  kafka-console-producer \
--broker-list localhost:9092 --topic test
