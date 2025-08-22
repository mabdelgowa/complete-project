FROM docker.io/golang:alpine3.22

RUN apk add --no-cache git
RUN addgroup -S appgroup && adduser -S -h /home/newuser -u 1001 newuser -G appgroup

RUN rm -f /bin/sh
# Set destination for COPY
WORKDIR  /home/newuser
USER newuser
# Download Go modules
COPY go.mod go.sum ./

RUN go mod download

# Copy the source code. Note the slash at the end, as explained in
COPY *.go ./

# Build
RUN CGO_ENABLED=0 GOOS=linux go build -o /home/newuser/docker-gs-ping


# To bind to a TCP port, runtime parameters must be supplied to the docker command.
EXPOSE 9090
# Run
CMD ["/home/newuser/docker-gs-ping"]
