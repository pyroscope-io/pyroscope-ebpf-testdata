#!/usr/bin/env bash
set -euxo pipefail

apt-get update


###################### PACKAGES ######################

apt-get -y install openssh-server iproute2 iptables gdb curl fuse-overlayfs gpg gpgv vim

###################### DOCKER ######################

# Add Docker's official GPG key:
apt-get -y install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update

apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin



###################### NETWORK ######################

echo "pyroscope_ebpf_test_vm" > /etc/hostname

config_path="/etc/systemd/network/20-interfaces.network"
cat > "$config_path" <<EOF
[Match]
Name=ens* enp* eth*
[Network]
DHCP=yes
DNS=8.8.8.8
DNS=8.8.4.4
EOF
chmod 644 "$config_path"

config_path="/etc/resolv.conf"
cat > "$config_path" <<EOF
nameserver 8.8.8.8
nameserver 8.8.4.4
nameserver 192.168.0.1
search TOTOLINK
EOF
chmod 644 "$config_path"


config_path="/etc/fstab"
cat > "$config_path" <<EOF
/dev/root / ext4 defaults,errors=remount-ro 0 1
EOF
chmod 644 "$config_path"

###################### SSH ######################

passwd -d root
config_path="/etc/ssh/sshd_config"
cat > "$config_path" <<EOF
# This is the sshd server system-wide configuration file.  See
# sshd_config(5) for more information.
PasswordAuthentication yes
PermitEmptyPasswords yes
PermitRootLogin yes
PubkeyAuthentication yes
AcceptEnv LANG LC_*
EOF
chmod 644 "$config_path"


###################### REST ######################


systemctl enable systemd-networkd
systemctl enable ssh.service
systemctl enable docker.service

#update-alternatives --set iptables /usr/sbin/iptables-legacy
#update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
#unlink /usr/sbin/iptables -> /tmp/tmp.SWY7A6UJT4/etc/alternatives/iptables # this is probably some farkechroot/chroot issue
#unlink /usr/sbin/iptables
#ln -s /usr/sbin/iptables-legacy /usr/sbin/iptables
#unlink /usr/sbin/ip6tables
#ln -s /usr/sbin/ip6tables-legacy /usr/sbin/ip6tables
#ls -l /usr/sbin/*tables