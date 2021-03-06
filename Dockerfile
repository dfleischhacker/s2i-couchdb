# couchdb-centos7
FROM openshift/base-centos7

# TODO: Put the maintainer name in the image metadata
LABEL maintainer="Daniel Fleischhacker <dev@dfleischhacker.de>"

# TODO: Rename the builder environment variable to inform users about application you provide them
ENV COUCHDB_VERSION 2.1.1

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="NoSQL database" \
      io.k8s.display-name="CouchDB 2.1.1" \
      io.openshift.expose-services="5984:http" \
      io.openshift.tags="couchdb,2.1.1"

COPY ./bintray-apache-couchdb-rpm.repo /etc/yum.repos.d/bintray-apache-couchdb-rpm.repo

# TODO: Install required packages here:
# RUN yum install -y ... && yum clean all -y
RUN yum -y install epel-release && yum -y install couchdb && yum clean all -y

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./s2i/bin/ /usr/libexec/s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
# RUN chown -R 1001:1001 /opt/app-root

# This default user is created in the openshift/base-centos7 image
USER 1001

# TODO: Set the default port for applications built using this image
EXPOSE 5984

# TODO: Set the default CMD for the image
# CMD ["/usr/libexec/s2i/usage"]
