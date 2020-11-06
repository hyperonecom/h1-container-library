FROM h1cr.io/website/ruby-passenger:2.7
COPY --from=h1cr.io/ws-server /opt/ws-server /opt/ws-server
CMD ["/opt/ws-server/server"]