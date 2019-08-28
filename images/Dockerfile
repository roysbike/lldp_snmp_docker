FROM centos:7
MAINTAINER Artem Gocnharenko <roysbike@gmail.com>

ENV CONFIG /etc/sysconfig/snmpd
ENV OPTIONS -LS0-6d

RUN yum install -y net-snmp \
                   net-snmp-utils && \
    curl -L http://download.opensuse.org/repositories/home:vbernat/RHEL_7/home:vbernat.repo -o /etc/yum.repos.d/vbernat.repo && \
    yum install -y lldpd && \
    mkdir -p /etc/snmp/conf.d

COPY config/snmpd.conf /etc/snmp/snmpd.conf
COPY config/lldpd.conf /etc/lldpd.conf
COPY assets/* /etc/snmp/conf.d/
COPY ./docker-entrypoint.sh /

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD [ "-s" ]

EXPOSE 161/udp
