FROM node:lts-alpine

WORKDIR /app

# Copy the package.json and install the dependencies
COPY package*.json ./
RUN npm ci --only=production
COPY . .

USER nobody:nobody

# Ideally set those for published images. To do so, run something like
#
#   docker build . \
#     --tag YOUR_TAG \
#     --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
#     --build-arg COMMIT=$(git rev-parse HEAD) \
#     --build-arg VERSION=$(git describe)
#
ARG BUILD_DATE
ARG COMMIT
ARG VERSION

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="lod.lobbywatch.ch" \
      org.label-schema.description="Linked Data Pilot" \
      org.label-schema.url="https://lod.lobbywatch.ch" \
      org.label-schema.vcs-url="https://github.com/zazuko/lod.lobbywatch.ch" \
      org.label-schema.vcs-ref=$COMMIT \
      org.label-schema.vendor="Zazuko" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

ENTRYPOINT []

# Using npm scripts for running the app allows two things:
#  - Handle signals correctly (Node does not like to be PID1)
#  - Let Skaffold detect it's a node app so it can attach the Node debugger
CMD ["npm", "run", "start"]

EXPOSE 8080
HEALTHCHECK CMD wget -q -O- http://localhost:8080/health
