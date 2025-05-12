FROM fauria/vsftpd

# Copiar configuración personalizada
COPY conf/vsftpd.conf /etc/vsftpd/

# Establecer permisos adecuados
RUN chown root:root /etc/vsftpd/vsftpd.conf && \
    chmod 600 /etc/vsftpd/vsftpd.conf

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]