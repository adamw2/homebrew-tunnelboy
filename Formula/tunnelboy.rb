class Tunnelboy < Formula
  desc "AWS VPC tunneling CLI with Pip-Boy theming"
  homepage "https://github.com/adamw2/tunnelboy"
  version "0.1.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.1.3/tunnelboy_darwin_arm64.tar.gz"
      sha256 "a256edef681ca26348a51dc3fd6d7cc03885ee386b286ea63009da2d85100cce"
    else
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.1.3/tunnelboy_darwin_amd64.tar.gz"
      sha256 "7b445e4db0e10b6d8389dd8d303ea9fb57c9b538428fb08d9bdd726c1ecdd5f4"
    end
  end

  depends_on :macos

  def install
    bin.install "tunnelboy"
  end

  def caveats
    <<~EOS
      TunnelBoy requires the AWS Session Manager plugin.
      Install it with:
        brew install --cask session-manager-plugin

      For shell completion, add to your ~/.zshrc:
        source <(tunnelboy completion zsh)

      For usage information:
        tunnelboy --help
    EOS
  end

  test do
    system "#{bin}/tunnelboy", "version"
  end
end
