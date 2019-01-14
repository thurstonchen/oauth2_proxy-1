FROM alpine:3.8
LABEL maintainer="Thurston Chen <thurston.chen@gmail.com>"

# When this Dockerfile was last refreshed (year/month/day)
ENV REFRESHED_AT 2019-01-14

# Install CA certificates
RUN apk add --no-cache --virtual=build-dependencies ca-certificates

ENV OAUTH2_PROXY_VERSION 2.2.1.1

# Checkout bitly's latest google-auth-proxy code from Github
RUN wget https://github.com/thurstonchen/oauth2_proxy/releases/download/V2.2.1.1-alpha/oauth2_proxy-2.2.1.1-alpha.linux-amd64.go1.11.4.tar.gz -O /tmp/oauth2_proxy.tar.gz \
        && tar -xf /tmp/oauth2_proxy.tar.gz -C ./bin --strip-components=1 \
        && rm /tmp/*.tar.gz

# Expose the ports we need and setup the ENTRYPOINT w/ the default argument
# to be pass in.
EXPOSE 8080 4180
ENTRYPOINT [ "./bin/oauth2_proxy" ]
CMD [ "--upstream=http://0.0.0.0:8080/", "--http-address=0.0.0.0:4180" ]
