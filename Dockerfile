FROM oraclelinux:7

ADD 22.1.0_CS64_LNX6.tar.gz /opt/opentext/cs_install
ADD apache-tomcat-9.0.62.tar.gz /opt/tomcat
ADD ./appimg.xml ./cs.xml ./cssupport.xml /opt/tomcat/conf/Catalina/localhost/
COPY install_parameters_cs /opt/opentext/cs_install
COPY install_parameters_tc /opt/tomcat

WORKDIR /opt/tomcat
RUN /bin/bash -c './setup < install_parameters_tc'

WORKDIR /opt/opentext/cs_install
RUN /bin/bash -c './setup < install_parameters_cs'

RUN /bin/bash -c 'yum install java'
RUN /bin/bash -c "(cd /opt/apache-tomcat*/bin; ./shutdown.sh; ./startup.sh)"
EXPOSE 8080
