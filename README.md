# action-parse-asdf-tool-versions

[![CI - Itself](https://github.com/kachick/action-parse-asdf-tool-versions/actions/workflows/validate.yml/badge.svg?branch=main)](https://github.com/kachick/action-parse-asdf-tool-versions/actions/workflows/validate.yml?query=branch%3Amain++)
[![CI - Test](https://github.com/kachick/action-parse-asdf-tool-versions/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/kachick/action-parse-asdf-tool-versions/actions/workflows/test.yml?query=branch%3Amain++)

- _**This repository is archived**_
- _**No longer maintained**_

Parse asdf .tool-versions and outputs with JSON for preparing GitHub Actions\
Tested on ubuntu-latest and macos-latest.

## Usage

Specify the path if you want. If not, `.tool-versions` will given

```yaml
jobs:
  asdf-parser:
    runs-on: ubuntu-latest
    timeout-minutes: 5
    steps:
      - uses: actions/checkout@v3
      - uses: kachick/action-parse-asdf-tool-versions@v3
        id: parse
        # with:
        #   # default '.tool-versions'
        #   tool-versions-path: 'asdf-managed-dir/.tool-versions'
    outputs:
      tool-versions: "${{ steps.parse.outputs.json }}"
  test:
    needs: [asdf-parser]
    timeout-minutes: 15
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: "${{ fromJson(needs.asdf-parser.outputs.tool-versions).nodejs }}"
      - run: npm ci
      - run: npm test
```

Major `setup-*` actions provide input option as `*-version`. Use this action and pass to them keep consistency of repository's .tool-versions and CI.\
Actual working examples are below.

- [nodejs](https://github.com/kachick/wait-other-jobs/blob/178c179e6658e757d7af0c08c35d1e2dc825481d/.github/workflows/test.yml#L36)
- [crystal](https://github.com/kachick/renovate-config-asdf/blob/d1426468e080110293038ec3ffed6aa843c93eae/.github/workflows/ci-crystal.yml#L41)
- [bun](https://github.com/kachick/kachick.github.io/blob/924a9306b48bdc5378426a84075908fc4cae1cdc/.github/workflows/lint.yml#L27)
- [dprint](https://github.com/kachick/renovate-config-asdf/blob/d1426468e080110293038ec3ffed6aa843c93eae/.github/workflows/lint.yml#L30)
