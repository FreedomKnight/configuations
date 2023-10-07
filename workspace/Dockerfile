from fedora:latest
# run dnf -y update
#run dnf -y install vim
run ["useradd", "FreedomKnight"]
run ["usermod", "-aG", "wheel", "FreedomKnight"]
run echo "%wheel        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
user FreedomKnight
workdir /home/FreedomKnight
entrypoint ["sleep",  "infinity"]

