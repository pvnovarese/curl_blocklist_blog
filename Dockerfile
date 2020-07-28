# example dockerfile that will use curl to download source, anchore
# will stop this with a simple package blacklist on curl
FROM alpine:latest 
MAINTAINER Paul Novarese pvn@novarese.net
LABEL name="curl_example"
LABEL maintainer="pvn@novarese.net"

WORKDIR /
RUN apk update && apk add -U tzdata bash git g++ make curl 

# download source and build
RUN curl -o - https://codeload.github.com/kevinboone/solunar_cmdline/zip/master | unzip -d / -
RUN cd /solunar_cmdline-master && make clean && make && cp solunar /bin/solunar

HEALTHCHECK --timeout=10s CMD /bin/date || exit 1
USER 65534:65534
CMD ["-c", "London"]
ENTRYPOINT ["/bin/solunar"]




### example multistage build - in this case, a simple package blacklist 
### will NOT stop this, since curl only is installed in the intermediate
### "builder" image and doesn't exist in the final image.  To stop this,
### we can look for curl in the RUN commands in the Dockerfile.

# ARG IMAGE=alpine
# ARG OS=linux
# ARG ARCH=amd64

# # STAGE 1
# FROM alpine:latest as builder
#
# WORKDIR /solunar_cmdline-master
# RUN apk update && apk add --no-cache git g++ make curl
# 
### Clone private repository
### NOTE: we could do something more conventional like:
### RUN git clone https://github.com/kevinboone/solunar_cmdline.git /solunar_cmdline
### and avoid the curl rule, but we can just as easily add similar
### rules for wget, git, etc
# RUN curl -o - https://codeload.github.com/kevinboone/solunar_cmdline/zip/master | unzip -d / -
# RUN make clean && make
# 
# FROM alpine:latest
# MAINTAINER Paul Novarese pvn@novarese.net
# LABEL name="solunar-demo"
# LABEL maintainer="pvn@novarese.net"
# 
# HEALTHCHECK --timeout=10s CMD /bin/date || exit 1
# WORKDIR /bin
# COPY --from=builder /solunar_cmdline-master/solunar solunar
# RUN apk add -U tzdata bash && cp /usr/share/zoneinfo/America/Chicago /etc/localtime

# USER 65534:65534
# CMD ["-c", "London"]
# ENTRYPOINT ["/bin/solunar"]
