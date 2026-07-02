class Tunnelboy < Formula
  desc "AWS VPC tunneling CLI with Pip-Boy theming"
  homepage "https://github.com/adamw2/tunnelboy"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.4.0/tunnelboy_darwin_arm64.tar.gz"
      sha256 "7e8e9733c7dc5da43af04786c6ace47024e2b7665170440c9fdc673f00286c5d"
    else
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.4.0/tunnelboy_darwin_amd64.tar.gz"
      sha256 "79c192dba41500064d14766d4d9cc6c313fe4fdaf1803d7b37a015ae75815640"
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
