FROM alpine:3.14.0
RUN apk add --update --upgrade \
    dosfstools jq parted sgdisk

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh
