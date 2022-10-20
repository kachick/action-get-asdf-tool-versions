# action-get-asdf-tool-versions

[![CI](https://github.com/kachick/action-get-asdf-tool-versions/actions/workflows/validate.yml/badge.svg?branch=main)](https://github.com/kachick/action-get-asdf-tool-versions/actions/workflows/validate.yml?query=branch%3Amain++)

Parse asdf managed .tool-versions with asdf-vm built-in features

# Usage

Only need `id` field for this action

```yaml
jobs:
  asdf-parser:
    runs-on: ubuntu-latest
    timeout-minutes: 5
    steps:
      - uses: actions/checkout@v3
      - uses: kachick/action-get-asdf-tool-versions
        id: parse
    outputs:
      tool-versions: ${{ steps.parse.outputs.json }}
  test:
    needs: [asdf-parser]
    timeout-minutes: 15
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: "${{ fromJson(needs.asdf-parser.tool-versions).nodejs }}"
      - run: npm ci
      - run: npm test
```
