FROM filebrowser/filebrowser:alpine
ENV FB_PORT=8080
ENV FB_ROOT=/data
ENV FB_NOAUTH=true
COPY ./entrypoint.sh ./entrypoint.sh
COPY ./database.db /database.db
ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["/filebrowser"]