class Pipeline < Formula
  desc "pipeline makes building up a pipeline of shell commands easier"
  homepage "https://github.com/codekitchen/pipeline"
  url "https://github.com/codekitchen/pipeline/releases/download/v1.0/pipeline-1.0.tar.gz"
  sha256 "83aae11654f73352491a900a9256bcbbec355b382e735d09f47df099afd533b9"
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
