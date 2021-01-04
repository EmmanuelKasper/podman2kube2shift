FROM registry.access.redhat.com/ubi8/ubi:8.3
RUN yum --disableplugin=subscription-manager -y module enable python36 \
  && yum --disableplugin=subscription-manager -y install python36 \
  && yum --disableplugin=subscription-manager clean all
WORKDIR /app
COPY . /app

RUN pip3 --no-cache-dir install -r requirements.txt

EXPOSE 5000
CMD ["/app/hello.py"]
