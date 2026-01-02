if ! test -f /opt/homebrew/bin/brew; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

export PATH=/opt/homebrew/bin:$PATH
brew install git
brew install mas

mas install 1352778147
echo "\nOpen Bitwarden desktop app and enable ssh agent..."
read -p "Press any key after enabling ssh agent..."
export SSH_AUTH_SOCK=/Users/niklas/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock
# ssh-add -L
# ssh -T git@github.com
if ! test -d ~/dotfiles; then
  git clone git@github.com:niklasi/dotfiles.git
fi





