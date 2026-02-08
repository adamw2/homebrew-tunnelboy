class Tunnelboy < Formula
  desc "AWS VPC tunneling CLI with Pip-Boy theming"
  homepage "https://github.com/adamw2/tunnelboy"
  version "0.1.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.1.2/tunnelboy_darwin_arm64.tar.gz"
      sha256 "7b594078e6cca5c13d21fdf9bf38e828fc833e81cc8b83f59c26536deb467f29"
    else
      url "https://github.com/adamw2/tunnelboy/releases/download/v0.1.2/tunnelboy_darwin_amd64.tar.gz"
      sha256 "0ff17dd20a3a4421f5637b554ee9c8a4e865013a2be6e3d233bb4f5c6250132d"
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
