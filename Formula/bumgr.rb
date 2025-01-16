class Bumgr < Formula
  include Language::Python::Virtualenv

  desc "Manage Backups with restic using a simple configuration file"
  homepage "https://github.com/3j14/bumgr"
  url "https://files.pythonhosted.org/packages/9b/8d/b2152aa1e809ef7b39730479a8182812b56ea822392781053b18cc8ac011/bumgr-0.5.1.tar.gz"
  sha256 "28c1738516f186dca7a0e520c82030f1fb8609c7b7d55283e63409b18619a96a"
  license "BSD-3-Clause"

  livecheck do
    url :stable
  end

  depends_on "python@3.13"
  depends_on "restic"

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/38/71/3b932df36c1a044d397a1f92d1cf91ee0a503d91e470cbd670aa66b07ed0/markdown-it-py-3.0.0.tar.gz"
    sha256 "e3f60a94fa066dc52ec76661e37c851cb232d92f9886b15cb560aaada2df8feb"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/7c/2d/c3338d48ea6cc0feb8446d8e6937e1408088a72a39937982cc6111d17f84/pygments-2.19.1.tar.gz"
    sha256 "61c16d2a8576dc0649d9f39e089b5f02bcd27fba10d8fb4dcc28173f7a45151f"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/ab/3a/0316b28d0761c6734d6bc14e770d85506c986c85ffb239e688eeaab2c2bc/rich-13.9.4.tar.gz"
    sha256 "439594978a49a09530cff7ebc4b5c7103ef57baf48d5ea3184f21d9a2befa098"
  end

  def install
    virtualenv_create(libexec, "python3")
    virtualenv_install_with_resources
  end

  test do
    resource "fixture.toml" do
      url "https://raw.githubusercontent.com/3j14/bumgr/refs/heads/main/tests/fixture.toml"
      sha256 "ea7411ba30c7df80197920a942a1575216dd9fb35fd797264c5383b769a498a6"
    end
    resource("fixture.toml").stage do
      assert_match(
        "RESTIC_REPOSITORY=\"test\" RESTIC_PASSWORD_COMMAND=\"echo 'foo'\" foo=\"bar\"",
        shell_output("#{bin}/bumgr -c fixture.toml env test"),
      )
    end
  end
end
