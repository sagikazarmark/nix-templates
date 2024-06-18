FROM --platform=$BUILDPLATFORM golang:1.22.1-alpine3.18@sha256:010f3b3cedc8f35696565597245598d46ecfdab6515d35439b72d2ddf601d7de AS builder

RUN apk add --update --no-cache ca-certificates git

ARG TARGETOS
ARG TARGETARCH
ARG TARGETPLATFORM

WORKDIR /usr/local/src/app

ARG GOPROXY

ENV CGO_ENABLED=0
ENV GOOS=$TARGETOS GOARCH=$TARGETARCH

COPY go.* ./
RUN go mod download

COPY . .

ARG VERSION

RUN go build -ldflags "-X main.version=${VERSION}" -o /usr/local/bin/app .


FROM alpine:3.20.0@sha256:77726ef6b57ddf65bb551896826ec38bc3e53f75cdde31354fbffb4f25238ebd

RUN apk add --update --no-cache ca-certificates tzdata

COPY --from=builder /usr/local/bin/app /usr/local/bin/

EXPOSE 8080

CMD app
