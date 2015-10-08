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

echo "Arduino installation"
yaourt -S --needed --noconfirm arduino
sudo gpasswd -a $USER uucp
sudo gpasswd -a $USER lock
sudo gpasswd -a $USER tty

echo "KDE configs"
rsync -vr $_cwd/config-files/ /home/$USER/.config/
