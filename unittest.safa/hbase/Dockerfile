FROM ubuntu:14.04
MAINTAINER jeevan

ARG hadoop_ver=2.7.0
ARG hbase_ver=1.1.8
ARG spark_ver=2.2.1

# Install Java
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-get update && \
    apt-get install -y software-properties-common ssh supervisor && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y oracle-java8-installer && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/oracle-jdk8-installer

# Install hadoop
RUN wget --progress=dot:giga -P /tmp/ https://archive.apache.org/dist/hadoop/core/hadoop-$hadoop_ver/hadoop-$hadoop_ver.tar.gz  && \
    mkdir -p /opt && \
    tar xzf /tmp/hadoop-$hadoop_ver.tar.gz -C /opt/ && \
    ln -s /opt/hadoop-$hadoop_ver /opt/hadoop && \
    rm /tmp/hadoop-$hadoop_ver.tar.gz && \
    rm -rf /opt/hadoop-$hadoop_ver/share/doc

# Install hbase
RUN wget --progress=dot:giga -P /tmp/ http://archive.apache.org/dist/hbase/$hbase_ver/hbase-$hbase_ver-bin.tar.gz && \
    tar xzf /tmp/hbase-$hbase_ver-bin.tar.gz -C /opt/ && \
    ln -s /opt/hbase-$hbase_ver /opt/hbase && \
    rm /tmp/hbase-$hbase_ver-bin.tar.gz && \
    rm -rf /opt/hbase-1.2.3/docs

# Install Spark
RUN wget --progress=dot:giga -P /tmp/ https://archive.apache.org/dist/spark/spark-$spark_ver/spark-$spark_ver-bin-hadoop2.7.tgz && \
    tar xzf /tmp/spark-$spark_ver-bin-hadoop2.7.tgz -C /opt/ && \
    ln -s /opt/spark-$spark_ver-bin-hadoop2.7 /opt/spark && \
    rm -rf /tmp/spark-$spark_ver-bin-hadoop2.7.tgz && \
    ln -s /opt/hbase/lib /opt/spark-$spark_ver-bin-hadoop2.7/lib

# Install Zookeeper
RUN wget --progress=dot:giga -P /tmp/ https://archive.apache.org/dist/zookeeper/zookeeper-3.4.12/zookeeper-3.4.12.tar.gz && \
    tar xzf /tmp/zookeeper-3.4.12.tar.gz -C /opt/ && \
    ln -s /opt/zookeeper-3.4.12 /opt/zookeeper && \
    rm -rf /tmp/zookeeper-3.4.12.tar.gz


# Generate ssh keys for hadoop/hbase start
ADD conf/ssh_config /root/.ssh/config
RUN ssh-keygen -t dsa -P '' -f /root/.ssh/id_dsa && \
    cat /root/.ssh/id_dsa.pub >> /root/.ssh/authorized_keys && \
    chmod 0600 /root/.ssh/authorized_keys

# Workaround for start ssh -D
RUN mkdir /var/run/sshd && chmod 0755 /var/run/sshd

# Configure Hadoop
RUN sed -i 's/${JAVA_HOME}/\/usr\/lib\/jvm\/java-8-oracle/g' /opt/hadoop-$hadoop_ver/etc/hadoop/hadoop-env.sh
ADD conf/core-site.xml /opt/hadoop-$hadoop_ver/etc/hadoop/core-site.xml
ADD conf/hdfs-site.xml /opt/hadoop-$hadoop_ver/etc/hadoop/hdfs-site.xml
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle/
RUN /opt/hadoop-$hadoop_ver/bin/hdfs namenode -format

# Configure Zookeeper

ADD /conf/zoo.cfg /opt/zookeeper/conf/zoo.cfg
RUN echo "export HBASE_MANAGES_ZK=true" >> /opt/hbase/conf/hbase-env.sh

# Configure hbase
RUN sed -i '2s/^/export JAVA_HOME=\/usr\/lib\/jvm\/java-8-oracle\n/' /opt/hbase/bin/hbase-config.sh
ADD conf/hbase-site.xml /opt/hbase/conf/hbase-site.xml
ADD conf/hbase-site.xml /opt/spark/conf/hbase-site.xml


# Configure spark
ADD conf/spark-env.sh /opt/spark/conf/spark-env.sh
ADD conf/spark-defaults.conf /opt/spark/conf/spark-defaults.conf
ADD conf/slaves /opt/spark/conf/slaves

# Configure supervisord
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD conf/bashrc /root/.bashrc


EXPOSE 22

CMD ["/usr/bin/supervisord"]

