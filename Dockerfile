# Stage 1: Build the Go binary
FROM golang:1.23-alpine AS builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy the Go source code and go.mod file into the container
COPY main.go go.mod ./

# Build the Go app statically with optimizations
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags="-s -w" -o hello-world .

# Stage 2: Create the minimal image
FROM scratch

# Copy the Go binary from the build stage
COPY --from=builder /app/hello-world /hello-world

# Command to run the executable
CMD ["/hello-world"]
