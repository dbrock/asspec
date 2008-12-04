package org.asspec.assert
{
  import org.asspec.Assert;
  import org.asspec.AssertionError;
  import org.asspec.util.Text;

  public class EqualityAssertionSpecification extends AssertionSpecification
  {
    override protected function execute() : void
    {
      requirement("asserting that null is not null should fail", function () : void {
        shouldFail(function () : void { Assert.notNull(null); }); });
      requirement("asserting that null equals null should pass", function () : void {
        shouldPass(function () : void { Assert.equal(null, null); }); });

      requirement("null should be same as null", function () : void {
        shouldBeSame(null, null); });
      requirement("null should not be same as object", function () : void {
        shouldNotBeSame(null, {}); });
      requirement("number should be same as itself", function () : void {
        shouldBeSame(1, 1); });
      requirement("string should be same as itself", function () : void {
        shouldBeSame("foo", "foo"); });
      requirement("empty arrays should not be same", function () : void {
        shouldNotBeSame([], []); });
      requirement("equal values should not be same", function () : void {
        shouldNotBeSame(new Value(1), new Value(1)); });
      requirement("value should be same as itself", function () : void {
        const value : Object = new Value(1);
        shouldBeSame(value, value);
      });

      function shouldBeSame(expected : Object, actual : Object) : void
      {
        shouldPass(function () : void { Assert.same(expected, actual); });
        shouldFail(function () : void { Assert.notSame(expected, actual); });
      }

      function shouldNotBeSame(expected : Object, actual : Object) : void
      {
        shouldPass(function () : void { Assert.notSame(expected, actual); });
        shouldFail(function () : void { Assert.same(expected, actual); });
      }

      (function () : void {
        const expected : String = "foo";
        const actual : String = "bar";

        requirement("asserting that equal strings are equal should pass", function () : void {
          shouldBeEqual(expected, expected); });
        requirement("asserting that different strings are equal should fail", function () : void {
          shouldNotBeEqual(expected, actual); });

        const error : AssertionError
          = getError(function () : void { Assert.equal(actual, expected); });

        requirement("equality assertion message should include expected value", function () : void {
          shouldContain(expected, error.message); });
        requirement("equality assertion message should include actual value", function () : void {
          shouldContain(actual, error.message); });
      })();

      function shouldContain(expected : String, actual : String) : void
      { assert(Text.contains(actual, expected), "was »" + actual + "«"); }

      function shouldBeEqual(expected : Object, actual : Object) : void
      {
        shouldPass(function () : void { Assert.equal(expected, actual); });
        shouldFail(function () : void { Assert.notEqual(expected, actual); });
      }

      function shouldNotBeEqual(expected : Object, actual : Object) : void
      {
        shouldPass(function () : void { Assert.notEqual(expected, actual); });
        shouldFail(function () : void { Assert.equal(expected, actual); });
      }

      requirement("string should equal itself", function () : void {
        shouldBeEqual("foo", "foo"); });
      requirement("string should not equal other string", function () : void {
        shouldNotBeEqual("foo", "bar"); });

      requirement("number should not equal string", function () : void {
        shouldNotBeEqual(1, "1"); });
      requirement("array should not equal string", function () : void {
        shouldNotBeEqual([], ""); });

      requirement("equal values should be equal", function () : void {
        shouldBeEqual(new Value(1), new Value(1));});
      requirement("value should not equal other value", function () : void {
        shouldNotBeEqual(new Value(1), new Value(2)); });

      requirement("entity should not equal other entity", function () : void {
        shouldNotBeEqual(new Entity, new Entity); });
      requirement("entity should equal itself", function () : void {
        const entity : Entity = new Entity;
        shouldBeEqual(entity, entity);
      });

      requirement("empty arrays should be equal", function () : void {
        shouldBeEqual([], []); });
      requirement("equal arrays should be equal", function () : void {
        shouldBeEqual([new Value(1)], [new Value(1)]); });
      requirement("non-equal arrays should not be equal", function () : void {
        shouldNotBeEqual([new Value(1)], [new Value(2)]); });

      (function () : void {
        const expected : Object = new CaseInsensitiveString("foo");
        const equal : Object = new CaseInsensitiveString("FOO");
        const error : AssertionError
          = getError(function () : void { Assert.notEqual(expected, equal); });

        requirement("non-equality message should include expected value", function () : void {
          shouldContain(expected.value, error.message); });
        requirement("non-equality message should include actual value", function () : void {
          shouldContain(equal.value, error.message); });
      })();

      requirement("asserting a value equals either nothing should not work", function () : void {
        shouldThrow(function () : void { Assert.equalsEither([], "foo"); }, ArgumentError); });
      requirement("asserting a value equals neither nothing should not work", function () : void {
        shouldThrow(function () : void { Assert.equalsNeither([], "foo"); }, ArgumentError); });

      function shouldEqualEither(expected : Array, actual : Object) : void
      {
        shouldPass(function () : void { Assert.equalsEither(expected, actual); });
        shouldFail(function () : void { Assert.equalsNeither(expected, actual); });
      }

      function shouldEqualNeither(expected : Array, actual : Object) : void
      {
        shouldPass(function () : void { Assert.equalsNeither(expected, actual); });
        shouldFail(function () : void { Assert.equalsEither(expected, actual); });
      }

      requirement("string should equal either itself", function () : void {
        shouldEqualEither(["foo"], "foo"); });
      requirement("string should equal neither another string", function () : void {
        shouldEqualNeither(["foo"], "bar"); });
      requirement("value should equal either an equal value", function () : void {
        shouldEqualEither([new Value(0)], new Value(0)); });
      requirement("number should equal neither a string", function () : void {
        shouldEqualNeither(["0"], 0); });
      requirement("string should equal either itself or another string", function () : void {
        shouldEqualEither(["foo", "bar"], "foo"); });
      requirement("string should equal either another string or itself", function () : void {
        shouldEqualEither(["bar", "foo"], "foo") });
      requirement("string should equal neither another string nor yet another string", function () : void {
        shouldEqualNeither(["bar", "baz"], "foo"); });

      (function () : void {
        const expected1 : String = "foo";
        const expected2 : String = "bar";
        const actual : String = "baz";

        const error : AssertionError
          = getError(function () : void { Assert.equalsEither([expected1, expected2], actual); });

        requirement("either-equality message should include first expected value", function () : void {
          shouldContain(expected1, error.message); });
        requirement("either-equality message should include second expected value", function () : void {
          shouldContain(expected2, error.message); });
        requirement("either-equality message should include actual value", function () : void {
          shouldContain(actual, error.message); });
      })();

      (function () : void {
        const expected1 : Object = new CaseInsensitiveString("foo");
        const expected2 : Object = new CaseInsensitiveString("bar");
        const actual : Object = new CaseInsensitiveString("FOO");
        const error : AssertionError
          = getError(function () : void { Assert.equalsNeither([expected1, expected2], actual); });

        requirement("neither-equality message should include first expected value", function () : void {
          shouldContain(expected1, error.message); });
        requirement("neither-equality message should include second expected value", function () : void {
          shouldContain(expected2, error.message); });
        requirement("neither-equality message should include actual value", function () : void {
          shouldContain(actual, error.message); });
        requirement("neither-equality message should include first expected value again", function () : void {
          shouldContainMultiple(expected1, error.message); });
      })();

      function shouldContainMultiple(expected : String, actual: String) : void
      { assert(actual.indexOf(expected) != actual.lastIndexOf(expected),
          "was »" + actual + "«"); }
    }
  }
}

import org.asspec.util.EqualityComparable;

class Entity {}

class Value implements EqualityComparable
{
  public var value : int;

  public function Value(value : int)
  { this.value = value; }

  public function equals(other : Object) : Boolean
  { return other is Value && Value(other).value == value; }
}

class CaseInsensitiveString implements EqualityComparable
{
  public var value : String;

  public function CaseInsensitiveString(value : String)
  { this.value = value; }

  public function equals(other : Object) : Boolean
  { return CaseInsensitiveString(other).value.toLowerCase() == value.toLowerCase(); }

  public function toString() : String
  { return value; }
}
