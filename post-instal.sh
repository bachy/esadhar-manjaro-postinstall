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
sudo pacman -S --needed --noconfirm gimp inkscape scribus fontforge blender

echo "Arduino installation"
yaourt -S --needed --noconfirm arduino
gpasswd -a $USER uucp
gpasswd -a $USER lock
gpasswd -a $USER tty

echo "KDE configs"
rsync -vr $_cwd/config-files/ /home/$USER/.config/
