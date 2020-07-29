# example dockerfile that will use curl to download source, anchore
# will stop this with a simple package blacklist on curl
FROM alpine:latest 
MAINTAINER Paul Novarese pvn@novarese.net
LABEL name="curl_example"
LABEL maintainer="pvn@novarese.net"
 
WORKDIR /
RUN apk update && apk add -U tzdata bash build-base gcc make curl 
 
# download source and build
RUN curl -o - https://codeload.github.com/kevinboone/solunar_cmdline/zip/master | unzip -d / -
RUN cd /solunar_cmdline-master && make clean && make && cp solunar /bin/solunar
 
HEALTHCHECK --timeout=10s CMD /bin/date || exit 1
USER 65534:65534
CMD ["-c", "London"]
ENTRYPOINT ["/bin/solunar"]
