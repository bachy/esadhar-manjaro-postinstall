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

echo "Packages installation"
sudo pacman -S --needed --noconfirm gimp inkscape scribus fontforge audacity blender vim chromium firefox-firebug firefox-adblock-plus

echo "Misc"

touch /home/$USER/.inputrc
echo 'set show-all-if-ambiguous on' >> /home/$USER/.inputrc
echo 'set completion-ignore-case on' >> /home/$USER/.inputrc

sudo pacman -S --needed --noconfirm bash-completion
sudo wget -O /etc/bash_completion.d/git-completion.bash https://github.com/git/git/blob/master/contrib/completion/git-completion.bash

cp $_cwd/vimrc /home/$USER/.vimrc
sudo cp $_cwd/vimrc /root/.vimrc

echo "Atom editor"
yaourt -S --needed --noconfirm atom-editor

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
  rsync -vr $_cwd/config-files/ /home/$USER/.config/
fi

echo "Node box installation"
sudo pacman -S --needed --noconfirm jdk7-openjdk apache-ant
cd /home/$USER/Documents
git clone git://github.com/nodebox/nodebox.git

echo -n "Reboot? [Y|n] "
read yn
yn=${yn:-y}
if [ "$yn" != "y" ]; then
  echo "please reboot"
  exit
fi

reboot
