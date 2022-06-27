import { jsonToType, typeToDart } from '../src/utils';
import { example } from '../src/example';
import fs from 'fs/promises';

(async () => {
  const json = JSON.parse(example);
  const resultExample = typeToDart(jsonToType(json), { name: 'Example', final: false, required: 'auto' }).join('\n');
  await fs.writeFile('./test/example.dart', resultExample, 'utf8');
  const resultExampleFinal = typeToDart(jsonToType(json), { name: 'ExampleFinal', final: true, required: 'auto' }).join('\n');
  await fs.writeFile('./test/example_final.dart', resultExampleFinal, 'utf8');
})();
