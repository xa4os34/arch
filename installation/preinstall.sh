exec iwctl
timedatectl

echo waiting for the internet connection
while ! ping -c 1 8.8.8.8 &> /dev/null; do 
    echo >/dev/null
done

echo updating mirrorlist
exec cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
exec curl https://archlinux.org/mirrorlist/?country=RU&country=GB&country=DE&protocol=https&use_mirror_status=on \
    | sed -e 's/^#Server/Server/' -e '/^#/d' \
    | rankmirrors -n 6 > /etc/pacman.d/mirrorlist

echo mount disks to /mnt
echo and then run install.sh script 
