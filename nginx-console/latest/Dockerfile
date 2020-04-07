FROM h1cr.io/website/nginx-static:latest
COPY --from=h1cr.io/ws-server /opt/ws-server /opt/ws-server
CMD ["/opt/ws-server/server"]
