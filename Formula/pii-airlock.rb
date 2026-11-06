class PiiAirlock < Formula
  include Language::Python::Virtualenv

  desc "Local privacy gateway that keeps PII out of LLM traffic"
  homepage "https://github.com/matinfo/pii-airlock"
  url "https://files.pythonhosted.org/packages/92/3c/fd95996cc2f1e2defbc9dbfbaf03f0159fa31860d0c8422683e04a6be088/pii_airlock-0.8.0.tar.gz"
  sha256 "92d607c969b2a5df9eca9858192db3049b68894da887520adbc9382679160b98"
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
