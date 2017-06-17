FROM busybox

#broker config
ADD broker/supervisord.conf /etc/supervisor/conf.d/broker/supervisord.conf
#coordinator config
ADD coordinator/supervisord.conf /etc/supervisor/conf.d/coordinator/supervisord.conf
#historical config
ADD historical/supervisord.conf /etc/supervisor/conf.d/historical/supervisord.conf
#supervisor config
ADD overlord/supervisord.conf /etc/supervisor/conf.d/overlord/supervisord.conf

VOLUME /etc/supervisor/conf.d
