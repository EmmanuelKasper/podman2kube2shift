FROM registry.access.redhat.com/ubi8/ubi:8.3
RUN yum -y module enable python36 \
  && yum -y install python36 \
  && yum clean all
WORKDIR /app
COPY . /app

RUN pip3 --no-cache-dir install -r requirements.txt

EXPOSE 8080
CMD ["/app/app.py"]
