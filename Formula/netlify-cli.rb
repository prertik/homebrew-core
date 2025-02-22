require "language/node"

class NetlifyCli < Formula
  desc "Netlify command-line tool"
  homepage "https://www.netlify.com/docs/cli"
  url "https://registry.npmjs.org/netlify-cli/-/netlify-cli-3.37.0.tgz"
  sha256 "f6a1cc2d2a5948d737ff63763577318d957f7847ea02f48012cc70638bbc30f7"
  license "MIT"
  head "https://github.com/netlify/cli.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d9519aa2cd4c58aed66815d666c9a93639209cd97afcc53951f16859992715aa"
    sha256 cellar: :any_skip_relocation, big_sur:       "2b7275a8815cfa05d80da0e6313a04f9bd1aa0c3c5e999e77ad1b5df376bc6f2"
    sha256 cellar: :any_skip_relocation, catalina:      "2b7275a8815cfa05d80da0e6313a04f9bd1aa0c3c5e999e77ad1b5df376bc6f2"
    sha256 cellar: :any_skip_relocation, mojave:        "2b7275a8815cfa05d80da0e6313a04f9bd1aa0c3c5e999e77ad1b5df376bc6f2"
  end

  depends_on "node"

  uses_from_macos "expect" => :test

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"test.exp").write <<~EOS
      spawn #{bin}/netlify login
      expect "Opening"
    EOS
    assert_match "Logging in", shell_output("expect -f test.exp")
  end
end
