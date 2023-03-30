#!/usr/bin/env bash

clear
echo "INSTALLING PACKAGES FOR EPITECH'S DUMP"
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
cat /etc/fedora-release | grep "Fedora release 38"
if [[ $? -ne 0 ]]; then
    echo "This script must be run onto a Fedora 38";
    exit 1
fi
echo "Press ENTER to continue..."
read

rpm --import https://packages.microsoft.com/keys/microsoft.asc
sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

dnf -y install dnf-plugins-core && dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf install fedora-workstation-repositories

dnf config-manager --set-enabled google-chrome

dnf upgrade -y


packages_list=(ca-certificates.noarch
               code
               curl.x86_64
               flac-devel.x86_64
               freetype-devel.x86_64
               gcc.x86_64
               gcc-c++.x86_64
               gdb.x86_64
               git
               glibc.x86_64
               glibc-devel.x86_64
               glibc-locale-source.x86_64
               gmp-devel.x86_64
               google-chrome-stable
               ksh.x86_64
               make.x86_64
               net-tools.x86_64
               python3-numpy.x86_64
               python3.x86_64
               rlwrap.x86_64
               tar.x86_64
               tcsh.x86_64
               tmux.x86_64
               sudo.x86_64
               tree.x86_64
               unzip.x86_64
               vim
               emacs-nox
               which.x86_64
               zip.x86_64
               zsh.x86_64
               docker
               docker-compose
               java-17-openjdk
               java-17-openjdk-devel
               nodejs
               emacs-tuareg
               libvirt
               libvirt-devel
               virt-install
               libgudev-devel
               php.x86_64
               php-devel.x86_64
               php-bcmath.x86_64
               php-cli.x86_64
               php-gd.x86_64
               php-mbstring.x86_64
               php-mysqlnd.x86_64
               php-pdo.x86_64
               php-pear.noarch
               php-xml.x86_64
               php-gettext-gettext.noarch
               php-phar-io-version.noarch
               php-theseer-tokenizer.noarch
               mariadb-server.x86_64
               x264.x86_64
               lightspark.x86_64
               lightspark-mozilla-plugin.x86_64)

dnf -y install ${packages_list[@]}


# Gradle
wget https://services.gradle.org/distributions/gradle-7.2-bin.zip
mkdir /opt/gradle && unzip -d /opt/gradle gradle-7.2-bin.zip && rm -f gradle-7.2-bin.zip
echo 'export PATH=$PATH:/opt/gradle/gradle-7.2/bin' >> /etc/profile


# CONFIG EMACS
git clone https://github.com/Epitech/epitech-emacs.git
cd epitech-emacs
git checkout 278bb6a630e6474f99028a8ee1a5c763e943d9a3
./INSTALL.sh system
cd .. && rm -rf epitech-emacs

# CONFIG VIM
git clone https://github.com/Epitech/vim-epitech.git
cd vim-epitech
git checkout ec936f2a49ca673901d56598e141932fd309ddac
./install.sh
cd .. && rm -rf vim-epitech
