class PiiAirlock < Formula
  include Language::Python::Virtualenv

  desc "Local privacy gateway that keeps PII out of LLM traffic"
  homepage "https://github.com/matinfo/pii-airlock"
  url "https://files.pythonhosted.org/packages/3f/69/c8ddd80fd02f2ee9c1a0d618f3d0f783c8bc16ac5fb154d4f9660e276f1d/pii_airlock-0.4.0.tar.gz"
  sha256 "d4e18e937fa6c4ed2331039bddb92e331856e831d55989247c66bfe09fc98f26"
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
