FROM debian:11

RUN apt-get update && apt-get install -y \
	wget \
	mono-devel \
	libmono-system-net-http4.0-cil \
	libmono-system-data4.0-cil \
	libmono-system-core4.0-cil \
	libmono-system-configuration4.0-cil \
	libmono-system-xml4.0-cil \
	libmono-system-security4.0-cil \
	libmono-microsoft-csharp4.0-cil \ 
	libmono-2.0-1 \ 
	gtk-sharp2 \
	libappindicator3-0.1-cil \
	&& rm -rf /var/lib/apt/lists/*

RUN wget https://updates.duplicati.com/beta/duplicati_2.0.6.3-1_all.deb \
&& dpkg -i duplicati_2.0.6.3-1_all.deb \
&& rm duplicati_2.0.6.3-1_all.deb

RUN useradd -ms /bin/bash duplicati

VOLUME ["/config", "/source", "/backups"]

EXPOSE 8200

USER duplicati

ENV URL_BASE /duplicati

CMD ["mono", "/usr/lib/duplicati/Duplicati.Server.exe", "--webservice-interface=any", "--server-datafolder=/config", "--webservice-allowed-hostnames=*", "--server-url-prefix=/duplicati"]