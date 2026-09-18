class Tunnelboy < Formula
  desc "AWS VPC tunneling CLI with Pip-Boy theming"
  homepage "https://github.com/adamw2/tunnelboy"
  version "0.7.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.7.0/tunnelboy_darwin_arm64.tar.gz"
      sha256 "5427cd462f20dfd10ea25400bef2e8407eed7b21f94cd722d949dbef80cbe0ca"
    else
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.7.0/tunnelboy_darwin_amd64.tar.gz"
      sha256 "43c7a0621acb7815b0360d850248292225e95097fccb7dff7e5a168a2b963389"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.7.0/tunnelboy_linux_arm64.tar.gz"
      sha256 "70e22de7de62fa342cb5d5ba61603ec0aabc52a9644c369710c84938dccca886"
    else
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.7.0/tunnelboy_linux_amd64.tar.gz"
      sha256 "503825fcfcb96cb1b5ca40c8a73eeac30c69ed5f3420e4e4a8a47729f364ff29"
    end
  end

  def install
    bin.install "tunnelboy"
  end

  def caveats
    <<~EOS
      TunnelBoy requires the AWS Session Manager plugin:
        macOS: brew install --cask session-manager-plugin
        Linux: https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html

      To enable zsh completion (copy and paste):
        grep -qxF 'autoload -Uz compinit && compinit' ~/.zshrc || echo 'autoload -Uz compinit && compinit' >> ~/.zshrc
        mkdir -p ~/.zsh/completions && tunnelboy completion zsh > ~/.zsh/completions/_tunnelboy
        grep -qxF 'fpath=(~/.zsh/completions $fpath)' ~/.zshrc || echo 'fpath=(~/.zsh/completions $fpath)' >> ~/.zshrc
        source ~/.zshrc

      To enable bash completion:
        echo 'source <(tunnelboy completion bash)' >> ~/.bashrc

      Get started:
        tunnelboy profile list
        tunnelboy connect rds
    EOS
  end

  test do
    system "#{bin}/tunnelboy", "version"
  end
end
