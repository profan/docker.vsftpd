FROM debian:jessie
MAINTAINER Robin Hübner "profan@prfn.se"

ENV hostname ""
RUN apt-get update && apt-get install -y --no-install-recommends vsftpd
RUN apt-get clean

RUN echo "pasv_address="$hostname >> /etc/vsftpd.conf
RUN echo "pasv_addr_resolve=YES" >> /etc/vsftpd.conf
RUN echo "pasv_enable=YES" >> /etc/vsftpd.conf
RUN echo "port_enable=YES" >> /etc/vsftpd.conf
RUN echo "pasv_min_port=10000" >> /etc/vsftpd.conf
RUN echo "pasv_max_port=10100" >> /etc/vsftpd.conf
RUN echo "anon_root=/var/ftp" >> /etc/vsftpd.conf
RUN echo "anon_max_rate=0" >> /etc/vsftpd.conf
RUN sed -i "s/local_enable=YES/local_enable=NO/" /etc/vsftpd.conf
RUN sed -i "s/anonymous_enable=NO/anonymous_enable=YES/" /etc/vsftpd.conf

RUN mkdir -p /var/run/vsftpd/empty
VOLUME /var/ftp

EXPOSE 20 21
EXPOSE 10000-10100

CMD /usr/sbin/vsftpd
