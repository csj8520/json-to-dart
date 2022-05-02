import { jsonToType, typeToDart } from '../src/utils';
import { example } from '../src/example';
import fs from 'fs/promises';

(async () => {
  const json = JSON.parse(example);
  const result = typeToDart(jsonToType(json), { name: 'Example', auto: true, final: false, required: false }).join('\n');
  await fs.writeFile('./test/example.dart', result, 'utf8');
})();
