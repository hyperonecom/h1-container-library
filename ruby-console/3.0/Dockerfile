FROM h1cr.io/website/ruby-passenger:3.0
COPY --from=h1cr.io/ws-server /opt/ws-server /opt/ws-server
CMD ["/opt/ws-server/server"]