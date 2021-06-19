echo -e "if [[ ! -f /home/jakub/.prgsetup/install.sh || "$(($(expr $(date +%s) - $(cat /home/jakub/.prgsetup/.last_update))/86400))" -gt "7" ]] ; then
    echo "Update your system..."
    sudo "/home/jakub/.prgsetup/install.sh"
fi" >> ~/.zshrc ~/.bashrc
