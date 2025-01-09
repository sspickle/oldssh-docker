# docker buildx build --push --platform linux/arm64,linux/amd64 --tag us.gcr.io/gcpdrive-sjstest/oldsssh:1 .

FROM gcc:4.9

RUN wget https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-6.7p1.tar.gz

RUN tar xzvf openssh-6.7p1.tar.gz

RUN cd openssh-6.7p1 && ./configure && make && make install

RUN mkdir /var/run/sshd

RUN echo 'root:password' | chpasswd

RUN cat ./openssh-6.7p1/sshd_config > /etc/ssh/sshd_config

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN groupadd -g 108 sshd

RUN useradd -u 108 -g 108 -c sshd -d / sshd

EXPOSE 22

CMD ["/usr/local/sbin/sshd", "-D"]

