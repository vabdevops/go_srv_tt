# Description: Multi-stage Dockerfile for a Go application
# Stage 1: Build Stage
FROM golang:latest as builder

# Set the working directory inside the container
WORKDIR /app

# Copy the go.mod and go.sum files
COPY go.mod go.sum ./
RUN --mount=type=cache,mode=0755,target=/go/pkg/mod \
    go mod download

# Copy the source code
COPY main.go .

# Build binary
RUN --mount=type=cache,mode=0755,target=/root/.cache/go-build \
    CGO_ENABLED=0 GOOS=linux go build -o main .

# Stage 2: Run Stage
FROM alpine:latest

# Install ca-certificates and timezone data
RUN apk --no-cache add ca-certificates tzdata shadow

# Set the timezone to UTC
WORKDIR /

# Copy the binary from the builder stage
COPY --from=builder /app/main .


# Create a non-root user to run the application
RUN adduser -D -g '' appuser && \
    chown -R appuser /main && \
    chmod +x /main

# Set the user to run the application
USER appuser

# Expose the port on which the application will run
EXPOSE 8080

# Run the application
CMD ["./main"]
