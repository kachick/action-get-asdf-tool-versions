import { stdin } from 'bun';

// https://www.typescriptlang.org/docs/handbook/release-notes/typescript-3-7.html#assertion-functions
export function assertIsDefined<T>(val: T): asserts val is NonNullable<T> {
  if (val === undefined || val === null) {
    throw new Error(`Expected 'val' to be defined, but received ${JSON.stringify(val)}`);
  }
}

// bun does not have readline. ref: https://github.com/oven-sh/bun/issues/311
const config = await stdin.text();
if (typeof config !== 'string') {
  throw new Error();
}
const lines = (config.split('\n').filter((line) => line));

const toolVersions: Record<string, string> = {};

for (const line of lines) {
  const [plugin, version] = line.split(/\s+/, 2);
  assertIsDefined<string | undefined>(plugin);
  assertIsDefined<string | undefined>(version);
  toolVersions[plugin] = version;
}

console.log(JSON.stringify(toolVersions));
