class Pipeline < Formula
  desc "Interactive prompt for building up a pipeline of shell commands"
  homepage "https://github.com/codekitchen/pipeline"
  url "https://github.com/codekitchen/pipeline/releases/download/v1.1/pipeline-1.1.tar.gz"
  sha256 "010ccdcbc523eb320b628ef75e77b37a02ad1a1e6fb4f51d4fa8f3d8df70e446"
  head do
    url "https://github.com/codekitchen/pipeline.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end
  uses_from_macos "libedit"
  uses_from_macos "ncurses"

  def install
    system "autoreconf", "-iv" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    # this is an interactive-only shell tool, so about the only thing we can do
    # without user interaction is run --version
    assert_match "pipeline", shell_output("#{bin}/pipeline --version")
  end
end
