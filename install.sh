echo -e "if [[ ! -f /home/jakub/.prgsetup/.last_update || "$(($(expr $(date +%s) - $(cat /home/jakub/.prgsetup/.last_update))/86400))" -gt "7" ]] ; then
    echo "Update your system..."
    sudo "/home/jakub/.prgsetup/run.sh"
fi" >> ~/.zshrc ~/.bashrc
