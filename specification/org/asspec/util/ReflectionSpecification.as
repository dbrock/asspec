package org.asspec.util
{
  import org.asspec.Assert;
  import org.asspec.spec.Specification;

  public class ReflectionSpecification extends Specification
  {
    override protected function execute() : void
    {
      assertLiteralInspections({
        "null": ["null", null],
        "true": ["true", true],
        "false": ["false", false],
        "zero": ["0", 0],
        "the empty string": ['""', ""],
        "an empty array": ["[]", []],
        "an empty object": ["{}", {}],

        "a simple integer":
          ["123", 123],
        "a simple floating-point number":
          ["123.456", 123.456],

        "a simple string":
          ['"abc"', 'abc'],
        "a string with quotes":
          ['"a\\"b\\"c"', 'a"b"c'],
        "a string with backslashes":
          ['"a\\\\b\\\\c"', 'a\\b\\c'],
        "a string with quotes and backslashes":
          ['"a\\\\\\"b\\"\\\\c"', 'a\\"b"\\c'],
        "a string with newlines":
          ['"a\\nb\\nc"', 'a\nb\nc'],
        "a string with carriage returns":
          ['"a\\r\\nb\\rc"', 'a\r\nb\rc'],
        "a string with tabs":
          ['"a\\tb\\tc"', 'a\tb\tc'],

        "an array of integers":
          ["[1, 2, 3]", [1, 2, 3]],
        "an array with an empty string":
          ['[""]', [""]],
        "a simple nested array":
          ['[[]]', [[]]],
        "a complex nested array":
          ['[[], ["", [""]]]', [[], ["", [""]]]],

        "a simple object":
          ["{ a: 1 }", { a: 1 }],
        "an object with two properties":
          [["{ a: 1, b: 2 }", "{ b: 2, a: 1 }"], { a: 1, b: 2 }],
        "a simple nested object":
          ["{ a: {} }", { a: {} }],
        "an object with a numeric property name":
          ['{ 0: {} }', { 0: {} }],
        "an object with a property name with a dollar sign":
          ['{ $a: {} }', { $a: {} }],
        "an object with a property name with an underscore":
          ['{ _a: {} }', { _a: {} }],
        "an object with a property name with a space":
          ['{ "a b": {} }', { "a b": {} }],
        "an object with an empty property name":
          ['{ "": {} }', { "": {} }]
      });
    }

    private function assertLiteralInspections(entries : Object) : void
    {
      for (var name : String in entries)
        assertLiteralInspection(name, entries[name][0], entries[name][1]);
    }

    private function assertLiteralInspection
      (description : String, expected : Object, actual : Object) : void
    { requirement("inspecting " + description + " should give its literal", function () : void {
        Assert.equalsEither(Arrays.wrap(expected), Reflection.inspect(actual)); }); }
  }
}
