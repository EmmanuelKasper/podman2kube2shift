FROM registry.access.redhat.com/ubi9/ubi:9.4
RUN yum -y install python3.11 python3-pip\
  && yum clean all
RUN useradd --no-log-init --key UID_MIN=50000 --user-group hello \
  && mkdir /app && chown hello:hello /app
USER 50000
WORKDIR /app
COPY . /app

RUN pip3 --no-cache-dir install --target /app --requirement requirements.txt

EXPOSE 8080
CMD ["/app/app.py"]
