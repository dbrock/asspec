package org.asspec.assertion
{
  import org.asspec.AssertionError;
  import org.asspec.classic.assertEquals;
  import org.asspec.classic.assertEqualsEither;
  import org.asspec.classic.assertEqualsNeither;
  import org.asspec.classic.assertNotEquals;
  import org.asspec.classic.assertNotNull;
  import org.asspec.classic.assertNotSame;
  import org.asspec.classic.assertSame;
  import org.asspec.util.Text;

  public class EqualityAssertionMetaspecification
    extends AbstractAssertionMetaspecification
  {
    override protected function execute() : void
    {
      requirement("asserting that null is not null should fail", function () : void {
        shouldFail(function () : void { assertNotNull(null); }); });
      requirement("asserting that null equals null should pass", function () : void {
        shouldPass(function () : void { assertEquals(null, null); }); });

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

      function shouldBeSame(actual : Object, expected : Object) : void
      {
        shouldPass(function () : void { assertSame(actual, expected); });
        shouldFail(function () : void { assertNotSame(actual, expected); });
      }

      function shouldNotBeSame(actual : Object, expected : Object) : void
      {
        shouldPass(function () : void { assertNotSame(actual, expected); });
        shouldFail(function () : void { assertSame(actual, expected); });
      }

      (function () : void {
        const expected : String = "foo";
        const actual : String = "bar";

        requirement("asserting that equal strings are equal should pass", function () : void {
          shouldBeEqual(expected, expected); });
        requirement("asserting that different strings are equal should fail", function () : void {
          shouldNotBeEqual(actual, expected); });

        const error : AssertionError
          = getError(function () : void { assertEquals(actual, expected); });

        requirement("equality assertion message should include actual value", function () : void {
          shouldContain(error.message, actual); });
        requirement("equality assertion message should include expected value", function () : void {
          shouldContain(error.message, expected); });
      })();

      function shouldContain(actual : String, expected : String) : void
      { assert(Text.of(actual).contains(expected), "was »" + actual + "«"); }

      function shouldBeEqual(actual : Object, expected : Object) : void
      {
        shouldPass(function () : void { assertEquals(actual, expected); });
        shouldFail(function () : void { assertNotEquals(actual, expected); });
      }

      function shouldNotBeEqual(actual : Object, expected : Object) : void
      {
        shouldPass(function () : void { assertNotEquals(actual, expected); });
        shouldFail(function () : void { assertEquals(actual, expected); });
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
          = getError(function () : void { assertNotEquals(equal, expected); });

        requirement("non-equality message should include actual value", function () : void {
          shouldContain(error.message, equal.value); });
        requirement("non-equality message should include expected value", function () : void {
          shouldContain(error.message, expected.value); });
      })();

      requirement("asserting a value equals either nothing should not work", function () : void {
        shouldThrow(function () : void { assertEqualsEither("foo", []); }, ArgumentError); });
      requirement("asserting a value equals neither nothing should not work", function () : void {
        shouldThrow(function () : void { assertEqualsNeither("foo", []); }, ArgumentError); });

      function shouldEqualEither(actual : Object, expected : Array) : void
      {
        shouldPass(function () : void { assertEqualsEither(actual, expected); });
        shouldFail(function () : void { assertEqualsNeither(actual, expected); });
      }

      function shouldEqualNeither(actual : Object, expected : Array) : void
      {
        shouldPass(function () : void { assertEqualsNeither(actual, expected); });
        shouldFail(function () : void { assertEqualsEither(actual, expected); });
      }

      requirement("string should equal either itself", function () : void {
        shouldEqualEither("foo", ["foo"]); });
      requirement("string should equal neither another string", function () : void {
        shouldEqualNeither("foo", ["bar"]); });
      requirement("value should equal either an equal value", function () : void {
        shouldEqualEither(new Value(0), [new Value(0)]); });
      requirement("number should equal neither a string", function () : void {
        shouldEqualNeither(0, ["0"]); });
      requirement("string should equal either itself or another string", function () : void {
        shouldEqualEither("foo", ["foo", "bar"]); });
      requirement("string should equal either another string or itself", function () : void {
        shouldEqualEither("foo", ["bar", "foo"]); });
      requirement("string should equal neither another string nor yet another string", function () : void {
        shouldEqualNeither("foo", ["bar", "baz"]); });

      (function () : void {
        const actual : String = "foo";
        const expected1 : String = "bar";
        const expected2 : String = "baz";

        const error : AssertionError
          = getError(function () : void { assertEqualsEither(actual, [expected1, expected2]); });

        requirement("either-equality message should include actual value", function () : void {
          shouldContain(error.message, actual); });
        requirement("either-equality message should include first expected value", function () : void {
          shouldContain(error.message, expected1); });
        requirement("either-equality message should include second expected value", function () : void {
          shouldContain(error.message, expected2); });
      })();

      (function () : void {
        const actual : Object = new CaseInsensitiveString("FOO");
        const expected1 : Object = new CaseInsensitiveString("foo");
        const expected2 : Object = new CaseInsensitiveString("bar");
        const error : AssertionError
          = getError(function () : void { assertEqualsNeither(actual, [expected1, expected2]); });

        requirement("neither-equality message should include actual value", function () : void {
          shouldContain(error.message, actual); });
        requirement("neither-equality message should include first expected value", function () : void {
          shouldContain(error.message, expected1); });
        requirement("neither-equality message should include second expected value", function () : void {
          shouldContain(error.message, expected2); });
        requirement("neither-equality message should include first expected value again", function () : void {
          shouldContainMultiple(error.message, expected1); });
      })();

      function shouldContainMultiple(actual: String, expected : String) : void
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

  public function equals(other : EqualityComparable) : Boolean
  { return other is Value && Value(other).value == value; }
}

class CaseInsensitiveString implements EqualityComparable
{
  public var value : String;

  public function CaseInsensitiveString(value : String)
  { this.value = value; }

  public function equals(other : EqualityComparable) : Boolean
  { return CaseInsensitiveString(other).value.toLowerCase() == value.toLowerCase(); }

  public function toString() : String
  { return value; }
}
