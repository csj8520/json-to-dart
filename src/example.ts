export const example = `{
  "string": "string",
  "boolean": true,
  "number": 123,
  "array int": [1, 2, 3],
  "abc-ss": 1,
  "array_string": ["2", "3", "4"],
  "array_dynamic": [1, "3", "4"],
  "string-force-maybe-null?": "1",
  "number-force-required!": 1,
  "obj": {
    "a": 1,
    "b": "1"
  },
  "arrayObj": [
    {
      "string": "string",
      "number": 123,
      "dyanmic": "22",
      "maybe-null": "23",
      "number-force-or-null?": 1,
      "deep-obj": {
        "ss": "33",
        "arr": [22]
      }
    },
    {
      "string": "string",
      "number": 123,
      "dyanmic": 2324,
      "arr": [1, 2, 3],
      "arr2": ["1", 2, 3],
      "number-force-maybe-null?": 1,
      "deep-obj": {
        "ss": "33"
      }
    }
  ]
}
`;