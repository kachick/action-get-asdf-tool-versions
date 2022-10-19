# action-get-asdf-tool-versions

[![CI](https://github.com/kachick/action-get-asdf-tool-versions/actions/workflows/validate.yml/badge.svg?branch=main)](https://github.com/kachick/action-get-asdf-tool-versions/actions/workflows/validate.yml?query=branch%3Amain++)

Parse asdf managed .tool-versions with asdf.sh built-in features

# Usage

Only need `id` field for this action

```yaml
jobs:
  test:
    timeout-minutes: 15
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: kachick/action-get-asdf-tool-versions
        id: asdf-tool_versions
      - uses: actions/setup-node@v3
        with:
          node-version: "${{ steps.asdf-tool_versions.nodejs }}"
      - run: npm ci
      - run: npm test
```
