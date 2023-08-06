FROM docker.io/golang:alpine3.18

# Set destination for COPY
WORKDIR /app
# t
# Download Go modules
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code. Note the slash at the end, as explained in
COPY *.go ./



# Build
RUN CGO_ENABLED=0 GOOS=linux go build -o /docker-gs-ping

# To bind to a TCP port, runtime parameters must be supplied to the docker command.
EXPOSE 9090

# Run
CMD ["/docker-gs-ping"]
