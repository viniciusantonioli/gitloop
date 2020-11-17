FROM google/dart

WORKDIR /app

RUN git config --global user.name "Vinícius Antonioli"

RUN git config --global user.email "viniciusantonioli.dev@gmail.com"

RUN curl -fsSL https://code-server.dev/install.sh | sh -s -- --dry-run

RUN curl -fsSL https://code-server.dev/install.sh | sh

COPY ./config.yaml /root/.config/code-server/config.yaml

ADD pubspec.* /app/

RUN pub get

ADD . /app

RUN pub get --offline

EXPOSE 5000

CMD []

ENTRYPOINT ["/bin/bash", "code-server", "--port", "5000"]