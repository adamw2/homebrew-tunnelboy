class Tunnelboy < Formula
  desc "AWS VPC tunneling CLI with Pip-Boy theming"
  homepage "https://github.com/adamw2/tunnelboy"
  version "0.6.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.6.1/tunnelboy_darwin_arm64.tar.gz"
      sha256 "f000f7d0d1a68fd477a4901104bc3bfc8f7e6d49bc8573ee2f5f08f9e906d2ad"
    else
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.6.1/tunnelboy_darwin_amd64.tar.gz"
      sha256 "9ddf20c710df010f66a55333c245e87594ed2789b2126eda3ff14b214db4806e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.6.1/tunnelboy_linux_arm64.tar.gz"
      sha256 "00902f952f8b5774492ddfd80710fd6e1ead9db7a768b0f14256e589482bc6db"
    else
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.6.1/tunnelboy_linux_amd64.tar.gz"
      sha256 "1004e7cdb093c27ee57e7ccc534ffa2aa81d8aa5fa34ddf48be21102beaa3aaf"
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
