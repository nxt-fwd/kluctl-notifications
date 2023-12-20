FROM golang:latest AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOARCH=amd64 go build pkg/controller/controller.go

FROM gcr.io/distroless/base-debian11
WORKDIR /root/
COPY --from=builder /app/controller .
CMD ["./controller"]
