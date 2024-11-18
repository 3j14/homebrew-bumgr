class Bumgr < Formula
  include Language::Python::Virtualenv

  desc "Manage Backups with restic using a simple configuration file"
  homepage "https://github.com/3j14/bumgr"
  url "{{ bumgr.url }}"
  {{ bumgr.checksum_type }} "{{ bumgr.checksum }}"
  license "BSD-3-Clause"

  livecheck do
    url :stable
  end

  depends_on "python@3.13"
  depends_on "restic"
  {% for resource in resources %}

  resource "{{ resource.name }}" do
    url "{{ resource.url }}"
    {{ resource.checksum_type }} "{{ resource.checksum }}"
  end
  {% endfor %}

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
