FROM --platform=$BUILDPLATFORM golang:1.21.5-alpine3.18@sha256:9390a996e9f957842f07dff1e9661776702575dd888084e72d86eaa382ad56e3 AS builder

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


FROM alpine:3.19.0@sha256:51b67269f354137895d43f3b3d810bfacd3945438e94dc5ac55fdac340352f48

RUN apk add --update --no-cache ca-certificates tzdata

COPY --from=builder /usr/local/bin/app /usr/local/bin/

EXPOSE 8080

CMD app
