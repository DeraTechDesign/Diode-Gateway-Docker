FROM ubuntu:20.04
RUN apt-get update
RUN apt-get -y install openssl
RUN apt-get -y install unzip
RUN apt-get -y install wget
RUN wget https://diode.io/install.sh
RUN chmod +x install.sh
RUN ./install.sh
RUN mkdir -p /etc/diode
RUN openssl genrsa > /etc/diode/privkey.pem
RUN openssl req -new -x509 -subj "/CN=diode" -key /etc/diode/privkey.pem > /etc/diode/fullchain.pem
EXPOSE 80 443 1080
RUN exec bash
CMD ./root/opt/diode/diode -dbpath=private.db gateway -httpd_port 80 -httpsd_port 443 -secure -certpath /etc/diode/fullchain.pem -privpath /etc/diode/privkey.pem -edge_acme -httpd_host 0.0.0.0 -httpsd_host 0.0.0.0 -proxy_host 0.0.0.0 -fallback false