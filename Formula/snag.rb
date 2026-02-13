class Snag < Formula
  desc "Copy on select for macOS — automatically copies selected text to clipboard"
  homepage "https://github.com/christi4nity/snag"
  url "https://github.com/christi4nity/snag/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "b199514d957a7a72673060865fa8c9431822ec91ea99d1c8ce420f82edc67019"
  license "MIT"

  depends_on xcode: ["14.0", :build]
  depends_on :macos => :ventura

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    mkdir_p "Snag.app/Contents/MacOS"
    cp ".build/release/Snag", "Snag.app/Contents/MacOS/Snag"
    cp "Sources/Snag/Info.plist", "Snag.app/Contents/Info.plist"
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
