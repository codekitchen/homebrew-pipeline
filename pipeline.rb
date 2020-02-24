class Pipeline < Formula
  desc "Interactive prompt for building up a pipeline of shell commands"
  homepage "https://github.com/codekitchen/pipeline"
  url "https://github.com/codekitchen/pipeline.git", :tag => "v1.5", :revision => "fdc56743fd9209abdc38db56c37e440c4a599e19"
  sha256 "d334b41a26a0a69d1e2ac2c952dc20a48480805673f4a9c086372b4a15cbc719"
  head do
    url "https://github.com/codekitchen/pipeline.git", :tag => "v1.5", :revision => "fdc56743fd9209abdc38db56c37e440c4a599e19"

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
