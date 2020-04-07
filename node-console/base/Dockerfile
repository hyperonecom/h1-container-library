FROM h1cr.io/website/node:{{NODE_VERSION}}
COPY --from=h1cr.io/ws-server /opt/ws-server /opt/ws-server
CMD ["/opt/ws-server/server"]