ARG VERSION=latest
FROM alpine:$VERSION as builder

RUN apk add musl-dbg

FROM scratch
COPY --from=builder /lib/ld-musl-aarch64.so.1 /lib/
COPY --from=builder /usr/lib/debug/lib/ld-musl-aarch64.so.1.debug /usr/lib/debug/lib/