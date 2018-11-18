docker run -d --name pause_container \
    -p 9092:9092 \
    -p 9093:9093 \
    -p 9094:9094 \
    -p 2181:2181 \
    -p 2182:2182 \
    -p 2183:2183 \
    gcr.io/google_containers/pause-amd64:3.0

docker exec kafka_broker_1 kafka-topics --zookeeper localhost:2181,localhost:2182,localhost:2183 --create --topic test --partitions 10 --replication-factor 3

docker exec -it kafka_broker_1 kafka-console-producer --broker-list localhost:9092,localhost:9093,localhost:9094 --topic test
docker exec -it kafka_broker_1 kafka-console-consumer --bootstrap-server localhost:9092,localhost:9093,localhost:9094 --topic test --from-beginning

docker run -it --net=container:pause_container --ipc=container:pause_container \
--pid=container:pause_container     confluentinc/cp-kafka:5.0.0  kafka-console-producer \
--broker-list localhost:9092,localhost:9093,localhost:9094 --topic test
