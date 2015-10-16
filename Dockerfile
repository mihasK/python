FROM mihas/civic-deps
RUN apt-get update
RUN apt-get install -y libpq-dev python-psycopg2 python-virtualenv

#=================================
# Python PIP packages
ADD ./requirements.txt .
RUN easy_install pip==7.1.2 && pip install -r requirements.txt && pip install pep8
#=================================


#=====================================
# SSH
#=====================================
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]

#=====================================

EXPOSE 8000

RUN mkdir /var/log/civic && chmod -R 777 /var/log/civic
