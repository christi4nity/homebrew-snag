class Snag < Formula
  desc "Copy on select for macOS — automatically copies selected text to clipboard"
  homepage "https://github.com/christi4nity/snag"
  url "https://github.com/christi4nity/snag/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "dd8d0c2b5b890b4645b8b78ebaf74531e2f86305a3ed94517f6cb212dfa14e25"
  license "MIT"

  depends_on xcode: ["14.0", :build]
  depends_on :macos => :ventura

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    mkdir_p "Snag.app/Contents/MacOS"
    mkdir_p "Snag.app/Contents/Resources"
    cp ".build/release/Snag", "Snag.app/Contents/MacOS/Snag"
    cp "Sources/Snag/Info.plist", "Snag.app/Contents/Info.plist"
    cp "Sources/Snag/Resources/AppIcon.icns", "Snag.app/Contents/Resources/AppIcon.icns"
    prefix.install "Snag.app"
  end

  def caveats
    <<~EOS
      Snag has been installed to:
        #{prefix}/Snag.app

      To use it:
        open #{prefix}/Snag.app

      You can also drag it to /Applications or add it to Login Items.
      Snag requires Accessibility permission — grant it when prompted.
    EOS
  end

  test do
    assert_predicate prefix/"Snag.app/Contents/MacOS/Snag", :executable?
  end
end
