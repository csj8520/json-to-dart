export interface JsonToType {
  key: string;
  types: ('string' | 'number' | 'boolean' | 'object' | 'array' | 'null')[];
  required: boolean;
  childrens: JsonToType[];
  item?: JsonToType;
}

export function jsonToType(json: any, preset?: Partial<JsonToType>): JsonToType {
  if (typeof json === 'string') return { key: '', types: ['string'], required: true, childrens: [], ...preset };
  if (typeof json === 'number') return { key: '', types: ['number'], required: true, childrens: [], ...preset };
  if (typeof json === 'boolean') return { key: '', types: ['boolean'], required: true, childrens: [], ...preset };
  if (json === null) return { key: '', types: ['null'], required: true, childrens: [], ...preset };
  if (!Array.isArray(json)) return jsonToType([json], { types: ['object'], ...preset });
  // if (!Array.isArray(json)) {
  //   const result: JsonToType = { key: '', types: ['object'], required: true, childrens: [], ...preset };
  //   for (const key in json) {
  //     result.childrens!.push(jsonToType(json[key]));
  //   }
  //   return result;
  // }

  const types: JsonToType['types'] = Array.from(new Set(json.map(it => (Array.isArray(it) ? 'arrry' : typeof it)))) as any;
  if (types.length > 1) {
    return { key: '', types: ['array'], required: true, childrens: [], item: { key: '', types, required: true, childrens: [] }, ...preset };
  } else if (types[0] !== 'object') {
    return { key: '', types: ['array'], required: true, childrens: [], item: { key: '', types, required: true, childrens: [] }, ...preset };
  }

  const result: JsonToType = { key: '', types: ['array'], required: true, childrens: [], ...preset };
  const keys = json.reduce((a, b) => ({ ...a, ...b }));
  for (const key in keys) {
    if (Array.isArray(keys[key])) {
      const values = json
        .map(it => it[key])
        .filter(it => it ?? false)
        .flat(1);
      const t = jsonToType(values, { key, required: json.filter(it => it[key] ?? false).length === json.length });
      result.childrens.push(t);
    } else {
      const values = json.map(it => it[key]).filter(it => it ?? false);
      const t = jsonToType(values, { key, types: ['object'], required: values.length === json.length });
      if (t.item) {
        t.types = t.item.types;
        delete t.item;
      }
      result.childrens.push(t);
    }
  }
  // const count: Record<string, number> = {};
  // for (let i = 0; i < json.length; i++) {
  //   for (const key in json[i]) {
  //     count[key] = (count[key] || 0) + 1;
  //     const has = result.childrens.find(it => it.key === key);
  //     if (has) {
  //       has.types.push(...jsonToType(json[i][key]).types);
  //       has.types = Array.from(new Set(has.types));
  //     } else {
  //       result.childrens.push(jsonToType(json[i][key], { key }));
  //     }
  //   }
  // }

  // for (const it of result.childrens) {
  //   it.required = count[it.key] === json.length;
  // }
  return result;
}
