FROM registry.access.redhat.com/ubi8/ubi:8.3
RUN yum -y module enable python36 \
  && yum -y install python36 \
  && yum clean all
RUN useradd --no-log-init --user-group --system hello \
  && mkdir /app && chown hello:hello /app
USER hello
WORKDIR /app
COPY . /app

RUN pip3 --no-cache-dir install --target /app --requirement requirements.txt

EXPOSE 8080
CMD ["/app/app.py"]
