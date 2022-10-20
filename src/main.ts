import { createInterface } from 'readline';

// https://www.typescriptlang.org/docs/handbook/release-notes/typescript-3-7.html#assertion-functions
export function assertIsDefined<T>(val: T): asserts val is NonNullable<T> {
  if (val === undefined || val === null) {
    throw new Error(`Expected 'val' to be defined, but received ${val}`);
  }
}

const reader = createInterface({
  input: process.stdin,
});

const toolVersions: { [key: string]: string } = {};

reader.on('line', (line) => {
  const [plugin, version] = line.split(/\s+/, 2);
  assertIsDefined<string | undefined>(plugin);
  assertIsDefined<string | undefined>(version);
  toolVersions[plugin] = version;
});

process.stdin.on('end', () => {
  console.log(JSON.stringify(toolVersions));
});
