class Tunnelboy < Formula
  desc "AWS VPC tunneling CLI with Pip-Boy theming"
  homepage "https://github.com/adamw2/tunnelboy"
  version "0.9.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.9.0/tunnelboy_darwin_arm64.tar.gz"
      sha256 "6450ca7f22ddec307a989bec9da8f2e124a578a3a3b09bcf9dab5cb79e2b99f1"
    else
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.9.0/tunnelboy_darwin_amd64.tar.gz"
      sha256 "2cc72aaf46d2259b86bd324fc065c17b1e68a69cd37c29cd76d7e68a619e1b90"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.9.0/tunnelboy_linux_arm64.tar.gz"
      sha256 "21e7bc9be6ba7a943fa31d85c5e11d40f2136728543581d32034f882ca20ff3d"
    else
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.9.0/tunnelboy_linux_amd64.tar.gz"
      sha256 "c594e1497158fcf2541f1c472a782bdd2a3eb5cc51d8cef5666618de142bae61"
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
