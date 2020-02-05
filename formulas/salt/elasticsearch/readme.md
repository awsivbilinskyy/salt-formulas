# documentation about salt elasticsearch role

temp notes:

```
cd /saltroot/formulas/ && git pull 

sudo salt -G 'roles:elasticsearch' state.sls elasticsearch 
```

```
sudo chown elasticsearch:elasticsearch -R /usr/share/elasticsearch && \
sudo chown elasticsearch:elasticsearch -R /var/log/elasticsearch && \
sudo chown elasticsearch:elasticsearch -R /var/lib/elasticsearch && \
sudo chown elasticsearch:elasticsearch -R /etc/default/elasticsearch && \
sudo chown elasticsearch:elasticsearch -R /etc/elasticsearch
```

Centosbag
https://discuss.elastic.co/t/elasticsearch-will-not-start-no-logs-code-exited-status-1-failure/135797