FROM golang:1.14 AS builder

ADD . /app
WORKDIR /app
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GO11MODULE=on go build -mod=vendor -a -o /main .

FROM gcr.io/distroless/base
COPY --from=builder --chown=nonroot:nonroot /main /kubernetes-event-exporter

USER nonroot

ENTRYPOINT ["/kubernetes-event-exporter"]
