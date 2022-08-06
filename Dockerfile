FROM debian

RUN apt-get update && \
    apt-get -y install openssh-server curl && \
    mkdir -p /run/sshd && \
    sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
    echo "root:origin123456" | chpasswd && \
    curl -fsSL https://github.com/erebe/wstunnel/releases/download/v4.1/wstunnel-x64-linux -o /usr/local/bin/wstunnel && \
    echo 'wstunnel --server wss://0.0.0.0:80 &' >> /entrypoint.sh && \
    echo '/usr/sbin/sshd -D' >> /entrypoint.sh && \
    chmod +x /usr/local/bin/wstunnel && \
    chmod +x /entrypoint.sh

EXPOSE 80

CMD /entrypoint.sh
