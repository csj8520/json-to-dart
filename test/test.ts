import { jsonToType, typeToDart } from '../src/utils';
import { example } from '../src/example';
import fs from 'fs/promises';

(async () => {
  const json = JSON.parse(example);
  const result = typeToDart(jsonToType(json), { name: 'Example', final: false, required: 'auto' }).join('\n');
  await fs.writeFile('./test/example.dart', result, 'utf8');
})();
