class PiiAirlock < Formula
  include Language::Python::Virtualenv

  desc "Local privacy gateway that keeps PII out of LLM traffic"
  homepage "https://github.com/matinfo/pii-airlock"
  url "https://files.pythonhosted.org/packages/ed/8c/ebcba5c2886f1baef2785d23e2b5fbc86001f1b82fc4941729b05a12741e/pii_airlock-0.5.0.tar.gz"
  sha256 "1783a630c82207ff3c40091d8bf9e00adf6440c8c72784fe268ee9fe1007c77a"
  license "MIT"

  depends_on "python@3.12"

  def install
    # spaCy, Presidio and cryptography ship binary wheels with a long native
    # dependency tree: install them into one venv from PyPI rather than
    # vendoring every wheel as a `resource` block.
    venv = virtualenv_create(libexec, "python3.12")
    system libexec/"bin/python", "-m", "pip", "install", "#{buildpath}[proxy]"
    bin.install_symlink libexec/"bin/pii-airlock"
  end

  def caveats
    <<~EOS
      Detection needs spaCy models (not bundled). Download them once:
        pii-airlock download-models
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pii-airlock --version")
  end
end
