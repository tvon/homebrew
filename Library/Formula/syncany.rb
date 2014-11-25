require "formula"

class Syncany < Formula
  homepage "https://www.syncany.org"
  url "https://codeload.github.com/syncany/syncany/tar.gz/v0.2.0-alpha"
  sha1 "5928db42002f2e9e0ffb76f94b7a9d81fa4fed89"
  version "0.2.0-alpha"
  head "https://github.com/syncany/syncany.git"

  depends_on :java => "1.7"

  def install
    system "./gradlew", "installApp"

    inreplace "build/install/syncany/bin/syncany" do |s|
      s.gsub! /APP_HOME="`pwd -P`"/, %{APP_HOME="#{libexec}"}
    end

    cd "build/install/syncany/bin" do
      rm Dir["*.bat"] # Windows batch scripts
      rm "syncany" # This is identical to the sy script, and the docs mostly refer to the sy script.
    end

    libexec.install Dir["build/install/syncany/*"]
    bin.install_symlink Dir["#{libexec}/bin/sy"]
  end

  test do
    system "#{bin}/sy", "-vv"
  end
end
