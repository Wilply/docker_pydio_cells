FROM golang:alpine AS builder

RUN apk --no-cache add git ca-certificates wget build-base

RUN [ -z "${VERSION}" ] && echo $(wget -q -O - https://api.github.com/repos/pydio/cells/releases/latest | grep tag_name | grep -Eo "([0-9]\.)+[0-9]") > /VERSION ; \
    [ -n "${VERSION}" ] && echo ${VERSION} > /VERSION ; true

WORKDIR /cells/src

RUN wget -q -O /tmp/cells.tar.gz https://github.com/pydio/cells/archive/v$(cat /VERSION).tar.gz && \
    tar --strip-components=1 -xzf /tmp/cells.tar.gz cells-$(cat /VERSION)/

RUN go get -d .

RUN VERSION=$(cat /VERSION) && CGO_ENABLED=1 GOOS=linux \
    go build \
    -o /cells/cells \
    -ldflags "-X github.com/pydio/cells/common.version=${VERSION}" \
    -a .

FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /cells

COPY --from=builder /cells/cells /cells/cells

COPY root/ /

RUN ln -s /cells/cells /bin/cells && \
    chmod -R 750 /cells /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["start"]

