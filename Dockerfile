FROM golang:1.23-alpine AS builder

ENV CGO_ENABLED=0

WORKDIR /build

COPY . /build

RUN go mod tidy

RUN go build -gcflags "-l" -ldflags "-w -s" -o fence main.go

FROM scratch

WORKDIR /app

COPY --from=builder /build/fence /app/fence

ENTRYPOINT [ "/app/fence" ]
