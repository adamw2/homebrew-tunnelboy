class Tunnelboy < Formula
  desc "AWS VPC tunneling CLI with Pip-Boy theming"
  homepage "https://github.com/adamw2/tunnelboy"
  version "0.8.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.8.0/tunnelboy_darwin_arm64.tar.gz"
      sha256 "a9d1cf00d957d6cf9ac18602f9f87089b18a0c1e62e9ee03cb30e8cdc5eee24a"
    else
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.8.0/tunnelboy_darwin_amd64.tar.gz"
      sha256 "d2034c968c5d1fb8eafdd195f8f26f6ff4c5509064b02f089cf4edf2045bfd9f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.8.0/tunnelboy_linux_arm64.tar.gz"
      sha256 "fc2249ff59f8a9de932d7ccc6bf1828fd806ebb9715c55504d69667924174f2a"
    else
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.8.0/tunnelboy_linux_amd64.tar.gz"
      sha256 "9bd8f7facda9d5e75a45c11aa45891e1a9f89c336954b2f47980823656b1ca84"
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
