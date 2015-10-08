#! /bin/sh


echo '\033[35m
                             #     #        ######
 ######  ####    ##   #####  #     #   ##   #     #    ##### #    # #    # #####   ####  #    #
 #      #       #  #  #    # #     #  #  #  #     #      #   #    #  #  #  #    # #    #  #  #
 #####   ####  #    # #    # ####### #    # ######       #   #    #   ##   #####  #    #   ##
 #           # ###### #    # #     # ###### #   #        #   #    #   ##   #    # #    #   ##
 #      #    # #    # #    # #     # #    # #    #       #   #    #  #  #  #    # #    #  #  #
 ######  ####  #    # #####  #     # #    # #     #      #    ####  #    # #####   ####  #    #

\033[0m'
echo "\033[35;1mThis script has been tested only on Linux Manjaro KDE \033[0m"
echo "Please run this script as root"

echo -n "Should we start? [Y|n] "
read yn
yn=${yn:-y}
if [ "$yn" != "y" ]; then
  echo "aborting script!"
  exit
fi

_cwd="$(pwd)"

echo "\033[35;1mPackages installation \033[0m"
pacman -S --needed --noconfirm gimp inkscape scribus fontforge blender

echo "\033[35;1mPackages installation \033[0m"
yaourt -S arduino
gpasswd -a $USER uucp
gpasswd -a $USER lock
gpasswd -a $USER tty

echo "\033[35;1mKDE configs \033[0m"
rsync -vr $_cwd/config-files/ ~/.config/
