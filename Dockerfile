FROM datadog/agent:latest

ENV DOCKERIZE_VERSION v0.6.1
RUN curl -OLs https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

COPY datadog-agent /

CMD ["dockerize", "-template", "/conf.d/postgres.d/conf.yaml.tmpl:/conf.d/postgres.d/conf.yaml", "/init"]
