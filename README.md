# homebrew-tap

Homebrew formulae for [pii-airlock](https://github.com/matinfo/pii-airlock).

```bash
brew install matinfo/tap/pii-airlock
pii-airlock download-models   # spaCy models, downloaded once
```

The formula installs `pii-airlock[proxy]` (CLI, hooks and gateway) into its own
virtualenv. Optional extras (`gliner`, `docx`, `pdf`) are not included: use
`pipx install "pii-airlock[all]"` for those.
