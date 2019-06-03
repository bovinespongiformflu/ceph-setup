#/bin/bash
#change hostname start
#echo "Enter new hostname: "
#read newhost
#hostnamectl set-hostname $newhost
#change hostname end

#dns and firewall start
#echo nameserver 8.8.8.8 | tee /etc/resolvconf/resolv.conf.d/base
#ufw disable
#dns and firewall end

#regen ssh keys start
#rm -v /etc/ssh/ssh_host_*
#dpkg-reconfigure openssh-server
#regen ssh keys end

#add ceph user start
useradd -d /home/cephd -m cephd
echo "cephd ALL = (root) NOPASSWD:ALL" | tee /etc/sudoers.d/cephd
echo "cephd:fastpass!" | chpasswd
#add ceph user end

#add ceph repo start

wget -q -O- 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc' | apt-key add -
#echo deb http://ceph.com/debian-hammer/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
#echo deb http://download.ceph.com/debian-jewel/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
echo deb http://download.ceph.com/debian-mimic/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list

apt-get update
apt-get install python -y
#add ceph repo end

#change system syscontrols start
echo kernel.pid_max = 4194303 >> /etc/sysctl.conf
echo net.ipv4.netfilter.ip_conntrack_max = 196608 >> /etc/sysctl.conf
echo net.netfilter.nf_conntrack_max = 1048576 >> /etc/sysctl.conf
echo net.core.rmem_max = 16777216 >> /etc/sysctl.conf
echo net.core.wmem_max = 16777216 >> /etc/sysctl.conf
echo net.core.wmem_default = 262144 >> /etc/sysctl.conf
echo net.core.rmem_default = 262144 >> /etc/sysctl.conf
echo net.ipv4.tcp_rmem = '8192 87380 16777216' >> /etc/sysctl.conf
echo net.ipv4.tcp_wmem = '4096 65536 16777216' >> /etc/sysctl.conf
echo net.core.netdev_max_backlog = 30000 >> /etc/sysctl.conf
echo net.ipv4.tcp_congestion_control = htcp >> /etc/sysctl.conf
echo net.ipv4.conf.all.rp_filter = 2 >> /etc/sysctl.conf
echo vm.swappiness = 0 >> /etc/sysctl.conf

#change system syscontrols end

#convert dhcp to static start
#apt-get install -y moreutils
#strip="$(ifdata -pa eth0)"
#strsub="$(ifdata -pn eth0)"
#strgw="$(ip route show 0.0.0.0/0 dev eth0 | cut -d\    -f3)"
#rm /etc/network/interfaces
#touch /etc/network/interfaces.d/eth0
#touch /etc/network/interfaces
#echo "auto lo" >> /etc/network/interfaces
#echo "iface lo inet loopback" >> /etc/network/interfaces
#echo "source-directory /etc/network/interfaces.d" >> /etc/network/interfaces
#echo "auto eth0" >> /etc/network/interfaces.d/eth0
#echo "iface eth0 inet static" >> /etc/network/interfaces.d/eth0
#echo "address $strip" >> /etc/network/interfaces.d/eth0
#echo "netmask $strsub" >> /etc/network/interfaces.d/eth0
#echo "gateway $strgw" >> /etc/network/interfaces.d/eth0
#convert dhcp to static end
