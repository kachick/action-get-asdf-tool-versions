# action-parse-asdf-tool-versions

[![CI](https://github.com/kachick/action-parse-asdf-tool-versions/actions/workflows/validate.yml/badge.svg?branch=main)](https://github.com/kachick/action-parse-asdf-tool-versions/actions/workflows/validate.yml?query=branch%3Amain++)

Parse asdf managed .tool-versions with [asdf-vm built-in function](https://github.com/asdf-vm/asdf/blob/eaf2215cb8adc9c3b74dbcbee034aba8ffa92dda/lib/utils.bash#L652-L662).\
So will work even if the .tool-versions using [comments](https://github.com/asdf-vm/asdf/blob/24b46078e33243596dede9c0b78b599a91c2e24c/docs/manage/configuration.md?plain=1#L22-L28) and [multiple versions](https://github.com/asdf-vm/asdf/blob/24b46078e33243596dede9c0b78b599a91c2e24c/docs/manage/configuration.md?plain=1#L39-L43).

# Usage

Only need `id` field for this action

```yaml
jobs:
  asdf-parser:
    runs-on: ubuntu-latest
    timeout-minutes: 5
    steps:
      - uses: actions/checkout@v3
      - uses: kachick/action-parse-asdf-tool-versions@v1
        id: parse
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
