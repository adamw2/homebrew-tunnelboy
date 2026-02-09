class Tunnelboy < Formula
  desc "AWS VPC tunneling CLI with Pip-Boy theming"
  homepage "https://github.com/adamw2/tunnelboy"
  version "0.1.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.1.5/tunnelboy_darwin_arm64.tar.gz"
      sha256 "d9cb75cac76debe8f300d886f36422907eda76b982600643a0125c5fe9496699"
    else
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.1.5/tunnelboy_darwin_amd64.tar.gz"
      sha256 "15b61ba67d7c35463779018d48934eb82a395915999c31edacb2237fd89e3f6e"
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
