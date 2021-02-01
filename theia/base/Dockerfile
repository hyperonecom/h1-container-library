FROM theiaide/theia:latest
ENV PORT 8080
RUN adduser --uid 23456 --disabled-password --gecos "" --home /data run-user && chown run-user:run-user -R /data
USER run-user
ADD ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
RUN sh -c "