# docker buildx build --push --platform linux/arm64,linux/amd64 --tag us.gcr.io/gcpdrive-sjstest/oldsssh:1 .

FROM gcc:4.9

RUN wget https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-6.7p1.tar.gz

RUN tar xzvf openssh-6.7p1.tar.gz

RUN cd openssh-6.7p1 && ./configure && make && make install

# RUN wget http://ftpmirror.gnu.org/emacs/emacs-24.3.tar.gz

# RUN tar -xzvf emacs-24.3.tar.gz

# RUN cd emacs-24.3 && ./configure --without-x && make && make install

RUN mkdir /var/run/sshd

RUN COPY sshd_config /etc/ssh/sshd_config

RUN groupadd -g 108 sshd

RUN useradd -u 108 -g 108 -c sshd -d / sshd

# RUN groupadd -g 109 rsync

# RUN mkdir -p /home/rsync

# RUN useradd -u 109 -g 109 -c rsync -d /home/rsync -s /bin/bash rsync 

# RUN chown -R rsync:rsync /home/rsync

EXPOSE 22

CMD ["/usr/local/sbin/sshd", "-D"]

