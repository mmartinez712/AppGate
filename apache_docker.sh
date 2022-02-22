#!/bin/sh
sudo -i
yum update -y
amazon-linux-extras install docker -y
yum install docker -y
service docker start
usermod -a -G docker ec2-user
systemctl enable docker
mkdir /home/ec2-user/Apache
touch /home/ec2-user/Apache/dockerfile
echo FROM ubuntu > /home/ec2-user/Apache/dockerfile
echo MAINTAINER appgate web >> /home/ec2-user/Apache/dockerfile
echo RUN "apt-get update && apt-get -y install cron" >> /home/ec2-user/Apache/dockerfile
echo RUN "apt-get install -y tzdata" >> /home/ec2-user/Apache/dockerfile
echo RUN "apt-get install -y apache2" >> /home/ec2-user/Apache/dockerfile
echo RUN touch /root/access.log >> /home/ec2-user/Apache/dockerfile
echo RUN chmod 777 /root/access.log >> /home/ec2-user/Apache/dockerfile
echo RUN "echo "appgate" > /var/www/html/index.html" >> /home/ec2-user/Apache/dockerfile
echo RUN "echo "grep '22/feb' /var/log/apache2/access.log | grep 'GET'" > /root/access.log > /root/script.sh" >> /home/ec2-user/Apache/dockerfile
echo RUN "echo "Total conexiones Appgate" >> /root/script.sh" >> /home/ec2-user/Apache/dockerfile
echo RUN "echo cat /root/access.log | wc -l >> /root/access.log >> /root/script.sh" >> /home/ec2-user/Apache/dockerfile
echo RUN "echo cp /root/access.log /var/www/html/index.html >> /root/script.sh" >> /home/ec2-user/Apache/dockerfile
echo RUN chmod 777 /root/script.sh >> /home/ec2-user/Apache/dockerfile
echo RUN chmod 666 /etc/crontab >> /home/ec2-user/Apache/dockerfile
echo RUN "echo */1  * * * * root /root/script.sh >> /etc/crontab" >> /home/ec2-user/Apache/dockerfile
echo EXPOSE 80 >> /home/ec2-user/Apache/dockerfile
echo CMD /usr/sbin/apache2ctl -D FOREGROUND >> /home/ec2-user/Apache/dockerfile
docker build -t appgate /home/ec2-user/Apache/
docker run -d -p 80:80 appgate


