FROM busybox:glibc

WORKDIR /cells

ENV CELLS_BIND localhost:8080
ENV CELLS_EXTERNAL localhost:8080
ENV PUID 1000
ENV PGID 1000
ENV SSL 1

RUN VERSION=$(wget -qO- https://api.github.com/repos/pydio/cells/releases/latest |grep tag_name|grep -oE "([0-9]\.)+[0-9]") && \
      wget -q "https://download.pydio.com/pub/cells/release/${VERSION}/linux-amd64/cells" && \
      wget -q "https://download.pydio.com/pub/cells/release/${VERSION}/linux-amd64/cells-ctl"

RUN mkdir -p /home/abc/.config

COPY root /

RUN ln -s /cells/cells /bin/cells && \
    ln -s /cells/cells-ctl /bin/cells-ctl && \
    ln -s /cells/libdl.so.2 /lib64/libdl.so.2

RUN chmod +x /cells/*

VOLUME ["/home/abc/.config"]

ENTRYPOINT ["/cells/entrypoint.sh"]

CMD ["start"]
