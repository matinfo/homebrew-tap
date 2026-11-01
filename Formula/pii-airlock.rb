class PiiAirlock < Formula
  include Language::Python::Virtualenv

  desc "Local privacy gateway that keeps PII out of LLM traffic"
  homepage "https://github.com/matinfo/pii-airlock"
  url "https://files.pythonhosted.org/packages/35/d0/137e4905039e53b2b502fa5021e54af6c2b8fcd3102322d6502aa6522357/pii_airlock-0.7.0.tar.gz"
  sha256 "f995920e46ba76fa0bbbab7e25b1c8c69da8e362495eae55aac03cc1ea785801"
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
