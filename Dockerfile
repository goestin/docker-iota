FROM debian:9

WORKDIR /opt
USER root
RUN apt-get update && \
	apt-get -y install wget openjdk-8-jre-headless && \
	wget https://github.com/iotaledger/iri/releases/download/v1.3/iri-1.3.0.jar && \
	mkdir -p /var/lib/iri


WORKDIR /var/lib/iri
VOLUME ["/var/lib/iri"]

EXPOSE 14800/udp
EXPOSE 14800/tcp

ADD config.ini.default /var/lib/iri/config.ini

ENTRYPOINT ["java", "-jar", "/opt/iri-1.3.0.jar"]
CMD ["-c", "config.ini", "--remote-limit-api", "\"removeNeighbors, addNeighbors\"", "--remote"]
