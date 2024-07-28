########## Builder ##########
FROM golang:1.22-alpine AS builder

# Install the latest version of Delve
RUN go install github.com/go-delve/delve/cmd/dlv@latest

# Copy local source
WORKDIR /build/
COPY . /build

# Build the binary
RUN CGO_ENABLED=0 GOOS=linux go build -o /build/go-debug-kube .

########## Runtime ##########
FROM alpine:3.15.0

WORKDIR /

# Copy binaries from builder
COPY --from=builder /build /
COPY --from=builder /go/bin/dlv /

# Expose both the apps port and debugger
EXPOSE 8080 40000

# Start Delve
CMD ["/dlv", "--listen=:40000", "--headless=true", "--api-version=2", "exec", "/go-debug-kube"]