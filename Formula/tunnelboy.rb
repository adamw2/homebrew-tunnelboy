class Tunnelboy < Formula
  desc "AWS VPC tunneling CLI with Pip-Boy theming"
  homepage "https://github.com/adamw2/tunnelboy"
  version "0.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.6.0/tunnelboy_darwin_arm64.tar.gz"
      sha256 "f1b73411ee9eacfff5b742a2d944afd2596cc4a21d2a49fc7e7daa13aa39f5e7"
    else
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.6.0/tunnelboy_darwin_amd64.tar.gz"
      sha256 "69ab38a552ef4f5bc15361cea142a7d6617336ef69a92f142b94c14e2d5dad73"
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
