import { JsonToType } from './json-to-type';

const typesMap: Record<string, string> = {
  string: 'String',
  number: 'int',
  boolean: 'bool',
  object: 'Map',
  array: 'List'
};
export interface TypeToDartConfig {
  name: string;
  required: 'auto' | 'force' | 'none';
  final: boolean;
}

export const typeToDart = (type: JsonToType, config: TypeToDartConfig): string[] => {
  config.name = bigCamelize(config.name);
  const strs: string[] = [];
  strs.push(`class ${config.name} {`);
  strs.push(...convertParams(type.childrens, config));
  strs.push('');
  strs.push(...convertKeys(type.childrens, config));
  strs.push('');
  strs.push(...convertFromJson(type.childrens, config));
  strs.push('');
  strs.push(...convertToJson(type.childrens, config));
  strs.push('');

  strs.push('  @override');
  strs.push('  String toString() {');
  strs.push('    return toJson().toString();');
  strs.push('  }');

  strs.push(`}`);

  for (const it of type.childrens) {
    if (it.types.length === 1 && it.types[0] === 'object') {
      strs.push('');
      strs.push(...typeToDart(it, { ...config, name: `${config.name} ${it.key}` }));
    } else if (it.types.length === 1 && it.types[0] === 'array' && !it.item) {
      strs.push('');
      strs.push(...typeToDart(it, { ...config, name: `${config.name} ${it.key} item` }));
    }
  }

  return strs;
};

const convertParams = (types: JsonToType[], config: TypeToDartConfig): string[] => {
  const strs: string[] = [];
  strs.push(`  ${config.name}({`);
  for (const it of types) {
    const { camelizeKey, required } = handleRequired({ key: it.key, config, required: it.required });
    const addRequired = required ? 'required ' : '';
    strs.push(`    ${addRequired}this.${camelizeKey},`);
  }
  strs.push(`  });`);
  return strs;
};

const convertKeys = (types: JsonToType[], config: TypeToDartConfig): string[] => {
  const strs: string[] = [];
  const addFinal = config.final ? 'final ' : '';
  for (const it of types) {
    const { camelizeKey, required } = handleRequired({ key: it.key, config, required: it.required });
    const addRequired = required ? '' : '?';
    const addLate = required ? 'late ' : '';
    let type = it.types.length > 1 ? 'dynamic' : typesMap[it.types[0]];
    if (type === 'List') {
      if (it.item) {
        const t = it.item.types.length > 1 ? 'dynamic' : typesMap[it.item.types[0]];
        type += `<${t}>`;
      } else {
        type += `<${bigCamelize(`${config.name} ${camelizeKey} item`)}>`;
      }
    } else if (type === 'Map') {
      type = `${bigCamelize(`${config.name} ${camelizeKey}`)}`;
    }
    strs.push(`  ${addLate}${addFinal}${type}${addRequired} ${camelizeKey};`);
  }
  return strs;
};

const convertFromJson = (types: JsonToType[], config: TypeToDartConfig): string[] => {
  const strs: string[] = [];
  strs.push(`  ${config.name}.fromJson(Map<String, dynamic> json) {`);
  for (const it of types) {
    const { key, camelizeKey, required } = handleRequired({ key: it.key, config, required: it.required });
    // const key = camelize(it.key);
    const addRequired = required ? '' : `if (json['${key}'] != null) `;
    if (it.types.length === 1 && it.types[0] === 'array') {
      if (it.item) {
        const t = it.item.types.length > 1 ? 'dynamic' : typesMap[it.item.types[0]];
        strs.push(`    ${addRequired}${camelizeKey} = List.castFrom<dynamic, ${t}>(json['${key}']);`);
      } else {
        strs.push(
          `    ${addRequired}${camelizeKey} = List.from(json['${key}']).map((e) => ${bigCamelize(
            `${config.name} ${key} item`
          )}.fromJson(e)).toList();`
        );
      }
    } else if (it.types.length === 1 && it.types[0] === 'object') {
      strs.push(`    ${addRequired}${camelizeKey} = ${bigCamelize(`${config.name} ${key}`)}.fromJson(json['${key}']);`);
    } else {
      strs.push(`    ${camelizeKey} = json['${key}'];`);
    }
  }
  strs.push('  }');
  return strs;
};

const convertToJson = (types: JsonToType[], config: TypeToDartConfig): string[] => {
  const strs: string[] = [];
  strs.push('  Map<String, dynamic> toJson() {');
  strs.push('    final _data = <String, dynamic>{};');
  for (const it of types) {
    const { key, camelizeKey, required } = handleRequired({ key: it.key, config, required: it.required });
    const addRequired = required ? '' : '?';
    if (it.types.length === 1 && it.types[0] === 'object') {
      strs.push(`    _data['${key}'] = ${camelizeKey}${addRequired}.toJson();`);
    } else if (it.types.length === 1 && it.types[0] === 'array' && !it.item) {
      strs.push(`    _data['${key}'] = ${camelizeKey}${addRequired}.map((e) => e.toJson()).toList();`);
    } else {
      strs.push(`    _data['${key}'] = ${camelizeKey};`);
    }
  }
  strs.push('    return _data;');
  strs.push('  }');
  return strs;
};

export const camelize = (str: string) => {
  return str.replace(/[-\s]+(\w)/g, (_, s) => s.toUpperCase());
};

export const bigCamelize = (str: string) => {
  const s = camelize(str);
  return s[0].toUpperCase() + s.substring(1);
};

interface HandleRequiredOption {
  key: string;
  config: TypeToDartConfig;
  required: boolean;
}

function handleRequired({ key, config, required }: HandleRequiredOption): { key: string; camelizeKey: string; required: boolean } {
  const last = key[key.length - 1];
  const _required = config.required === 'auto' ? required : config.required === 'force';
  const _key = key.replace(/[!?]$/, '');
  return {
    key: _key,
    camelizeKey: camelize(_key),
    required: last === '!' ? true : last === '?' ? false : _required
  };
}
