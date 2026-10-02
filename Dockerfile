FROM madnificent/lisp-webservice:feature-modernize

RUN apt-get update; apt-get -y upgrade; apt-get install -y libev-dev gcc;
RUN mkdir -p /data/strings/
RUN touch /data/.unmounted-data-folder

ENV SYSTEMS="SPARQL-PARSER"
ENV LISP_DYNAMIC_SPACE_SIZE=4096

COPY ./launch-sparql-parser.sh /

RUN ["/usr/src/load.sh"]

CMD ["/launch-sparql-parser.sh"]

COPY . /app

# Support running as an arbitrary UID in group 0 (OpenShift restricted SCC)
RUN mkdir -p /config \
 && chmod 755 /usr/local/bin/sbcl \
 && chgrp -R 0 /root /app /config /data \
 && chmod -R g=u /root /app /config /data /etc/passwd
ENV HOME=/root

EXPOSE 8890
