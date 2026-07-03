class Tunnelboy < Formula
  desc "AWS VPC tunneling CLI with Pip-Boy theming"
  homepage "https://github.com/adamw2/tunnelboy"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.5.0/tunnelboy_darwin_arm64.tar.gz"
      sha256 "fbae58b42e1fc14f67da68eb665db4f56121e2252dd7cf87467859ced32ba254"
    else
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.5.0/tunnelboy_darwin_amd64.tar.gz"
      sha256 "298b3e8f8d013c70990d2b8311462f3be1c2089c7a13f3777764d74b44234268"
    end
  end

  depends_on :macos

  def install
    bin.install "tunnelboy"
  end

  def caveats
    <<~EOS
      TunnelBoy requires the AWS Session Manager plugin:
        brew install --cask session-manager-plugin

      To enable shell completion (copy and paste):
        grep -qxF 'autoload -Uz compinit && compinit' ~/.zshrc || echo 'autoload -Uz compinit && compinit' >> ~/.zshrc
        mkdir -p ~/.zsh/completions && tunnelboy completion zsh > ~/.zsh/completions/_tunnelboy
        grep -qxF 'fpath=(~/.zsh/completions $fpath)' ~/.zshrc || echo 'fpath=(~/.zsh/completions $fpath)' >> ~/.zshrc
        source ~/.zshrc

      Get started:
        tunnelboy profile list
        tunnelboy connect rds
    EOS
  end

  test do
    system "#{bin}/tunnelboy", "version"
  end
end
