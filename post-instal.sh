#! /bin/sh


echo '
                             #     #        ######
 ######  ####    ##   #####  #     #   ##   #     #    ##### #    # #    # #####   ####  #    #
 #      #       #  #  #    # #     #  #  #  #     #      #   #    #  #  #  #    # #    #  #  #
 #####   ####  #    # #    # ####### #    # ######       #   #    #   ##   #####  #    #   ##
 #           # ###### #    # #     # ###### #   #        #   #    #   ##   #    # #    #   ##
 #      #    # #    # #    # #     # #    # #    #       #   #    #  #  #  #    # #    #  #  #
 ######  ####  #    # #####  #     # #    # #     #      #    ####  #    # #####   ####  #    #
'
echo "This script has been tested only on Linux Manjaro KDE"
#echo "Please run this script as root"

echo -n "Should we start? [Y|n] "
read yn
yn=${yn:-y}
if [ "$yn" != "y" ]; then
  echo "aborting script!"
  exit
fi

_cwd="$(pwd)"

sudo pacman -Syyu

echo "I love candy! (pacman)"
sudo sed -i.back 's/^#Color$/Color/' /etc/pacman.conf
sudo sed -i.back 's/^#TotalDownload$/TotalDownload\nILoveCandy/' /etc/pacman.conf
# sudo sed -i.back 's/.*\[options\].*/&\nILoveCandy/' /etc/pacman.conf

echo "install avahi"
sudo pacman -S --needed --noconfirm -q avahi nss-mdns
echo "configure avahi"
sudo systemctl enable avahi-daemon
sudo systemctl start avahi-daemon
sudo sed -i.back 's/hosts: files dns myhostname/hosts: files mdns_minimal [NOTFOUND=return] dns myhostname/' /etc/nsswitch.conf

echo "Kde improvement"
sudo pacman -S --needed --noconfirm dolphin-plugins kdenetworks-sharing kdeplasma-addons

echo "Packages installation"
sudo pacman -S --needed --noconfirm atom gimp digikam darktable inkscape scribus fontforge audacity blender vim chromium firefox-developer-edition firefox-adblock-plus

echo "Yaourt"
sudo pacman -S --needed base-devel
mkdir -p /home/$USER/Developer/Linux/build-repos
wget -O /home/$USER/Developer/Linux/build-repos/package-query.tar.gz https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz
wget -O /home/$USER/Developer/Linux/build-repos/yaourt.tar.gz https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
cd /home/$USER/Developer/Linux/build-repos
tar -xvf package-query.tar.gz
tar -xvf yaourt.tar.gz
cd package-query
makepkg -sri
cd ../yaourt
makepkg -sri
echo 'ask for editing config file before build'
echo "EDITFILES=1" >> ~/.yaourtrc
echo "Yaourt install complete!"

# TODO: install samba

echo "Misc"

touch /home/$USER/.inputrc
echo 'set show-all-if-ambiguous on' >> /home/$USER/.inputrc
echo 'set completion-ignore-case on' >> /home/$USER/.inputrc

sudo pacman -S --needed --noconfirm bash-completion
sudo wget -O /etc/bash_completion.d/git-completion.bash https://github.com/git/git/blob/master/contrib/completion/git-completion.bash

cp $_cwd/vimrc /home/$USER/.vimrc
sudo cp $_cwd/vimrc /root/.vimrc

echo "Arduino installation"
yaourt -S --needed --noconfirm arduino
sudo gpasswd -a $USER uucp
sudo gpasswd -a $USER lock
sudo gpasswd -a $USER tty

echo "KDE configs"
echo -n "update all config files? [Y|n] "
read yn
yn=${yn:-y}
if [ "$yn" != "y" ]; then
  rsync -vr $_cwd/config-files/ /home/$USER/
fi

echo "Node box installation"
# sudo pacman -S --needed --noconfirm jdk7-openjdk apache-ant
# cd /home/$USER/Documents
# git clone git://github.com/nodebox/nodebox.git
yaourt -S nodebox

echo -n "Reboot? [Y|n] "
read yn
yn=${yn:-y}
if [ "$yn" != "y" ]; then
  echo "please reboot"
  exit
fi

reboot
