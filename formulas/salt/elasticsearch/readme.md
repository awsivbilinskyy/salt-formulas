# documentation about salt elasticsearch role
contents:
- [my temp notes]()
- [Role description]()
- [Some known issues I've Faced with ELK]()




my temp notes:
---
```
cd /saltroot/formulas/ && git pull 

sudo salt -G 'roles:elasticsearch' state.sls elasticsearch 

cd /saltroot/formulas && \
sudo git pull



```
sudo salt-run state.event pretty=True

sudo -u elasticsearch /usr/share/elasticsearch/bin/elasticsearch -p /tmp/elasticsearch.pid 
```
sudo chown elasticsearch:elasticsearch -R /usr/share/elasticsearch && \
sudo chown elasticsearch:elasticsearch -R /var/log/elasticsearch && \
sudo chown elasticsearch:elasticsearch -R /var/lib/elasticsearch && \
sudo chown elasticsearch:elasticsearch -R /etc/default/elasticsearch && \
sudo chown elasticsearch:elasticsearch -R /etc/elasticsearch && \

```
[Configure elasticsearch on Centos7](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-elasticsearch-on-centos-7)

# Role description

local VM's verification links:
http://192.168.56.42:9200/

http://192.168.56.41:9200/



# Local VM's links to tests infrastructure:

**Salt Master VM:**
- ssh                       ```vagrant ssh salt```
- command to acces salt event bus ```sudo salt-run state.event pretty=True```
- update local repo from remote ```cd /saltroot && sudo git pull```

**Minion1 (to run logstash) VM:**
- ssh                      ```vagrant ssh minion1```
- logstash interface:      http://

**Elastic search VM:**
- ssh                       ```vagrant ssh elasticsearch```
- elasticsearch interface:  http://192.168.56.43:9200/
- kibana interface:         http://192.168.56.43:5601/
- kibana proxied interface: http://192.168.56.43:80


cluster.name: myES_Cluster
node.name: ESNODE_CYR
node.master: true
node.data: true
transport.host: localhost
transport.tcp.port: 9300
http.port: 9200
network.host: 0.0.0.0
discovery.zen.minimum_master_nodes: 2



**Some known issues I've Faced with ELK:**
---
[elastic bug with Centos 7](https://discuss.elastic.co/t/elasticsearch-will-not-start-no-logs-code-exited-status-1-failure/135797)
problem during elasticsearch start:
```
[vagrant@minion2 ~]$ sudo systemctl status elasticsearch.service -l
● elasticsearch.service - Elasticsearch
   Loaded: loaded (/usr/lib/systemd/system/elasticsearch.service; enabled; vendor preset: disabled)
  Drop-In: /etc/systemd/system/elasticsearch.service.d
           └─override.conf
   Active: failed (Result: exit-code) since Wed 2020-02-05 09:36:22 UTC; 6min ago
     Docs: http://www.elastic.co
  Process: 1015 ExecStart=/usr/share/elasticsearch/bin/elasticsearch -p ${PID_DIR}/elasticsearch.pid --quiet (code=exited, status=1/FAILURE)
 Main PID: 1015 (code=exited, status=1/FAILURE)

Feb 05 09:36:04 minion2 systemd[1]: Starting Elasticsearch...
Feb 05 09:36:08 minion2 elasticsearch[1015]: OpenJDK 64-Bit Server VM warning: Option UseConcMarkSweepGC was deprecated in version 9.0 and will likely be removed in a future release.
Feb 05 09:36:22 minion2 systemd[1]: elasticsearch.service: main process exited, code=exited, status=1/FAILURE
Feb 05 09:36:22 minion2 systemd[1]: Failed to start Elasticsearch.
Feb 05 09:36:22 minion2 systemd[1]: Unit elasticsearch.service entered failed state.
Feb 05 09:36:22 minion2 systemd[1]: elasticsearch.service failed.
```
solution:
- **Solved**. Problem was that the JAVA_HOME setting in **/etc/sysconfig/elasticsearch** was pointing too far down the Java path. Should have been **/usr/openv/java**



 /usr/bin/java 



 sudo salt '*' network.interface_ip enp0s8


 https://www.reddit.com/r/saltstack/comments/36mcmv/get_remote_or_multiple_minion_ip_address_in_jinja/