FROM postgres:9.6.16
RUN apt-get update && apt-get install -y --no-install-recommends \
	apt-utils \
	curl \
	ca-certificates \
	build-essential \
	postgresql-server-dev-${PG_MAJOR} \
	libssl-dev \
	libkrb5-dev
	
RUN mkdir -p /tmp/pgaudit && cd /tmp/pgaudit && curl -L https://github.com/pgaudit/pgaudit/archive/1.1.2.tar.gz | tar xz --strip 1
RUN make -C /tmp/pgaudit/ install USE_PGXS=1

COPY ./my-docker-entrypoint.sh /usr/local/bin/
COPY init.sql /docker-entrypoint-initdb.d/

ENTRYPOINT ["bash", "my-docker-entrypoint.sh"]
CMD ["postgres"]