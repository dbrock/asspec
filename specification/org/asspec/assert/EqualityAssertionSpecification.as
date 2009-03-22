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

      (function () : void {
        const expected : String = "foo";
        const actual : String = "bar";

        requirement("asserting that equal strings are equal should pass", function () : void {
          shouldPass(function () : void { Assert.equal(expected, expected); }); });
        requirement("asserting that different strings are equal should fail", function () : void {
          shouldFail(function () : void { Assert.equal(expected, actual); }); });

        const error : AssertionError
          = getError(function () : void { Assert.equal(actual, expected); });

        requirement("equality assertion message should include expected value", function () : void {
          assert(Text.contains(error.message, expected)); });
        requirement("equality assertion message should include actual value", function () : void {
          assert(Text.contains(error.message, actual)); });
      })();

      requirement("asserting that different strings are not equal should pass", function () : void {
        shouldPass(function () : void { Assert.notEqual("foo", "bar"); }); });
      requirement("asserting that equal strings are not equal should fail", function () : void {
        shouldFail(function () : void { Assert.notEqual("foo", "foo"); }); });

      requirement("asserting that a number equals a string should fail", function () : void {
        shouldFail(function () : void { Assert.equal(1, "1"); }); });
      requirement("asserting that an array equals a string should fail", function () : void {
        shouldFail(function () : void { Assert.equal([], ""); }); });

      requirement("asserting that a number does not equal a string should pass", function () : void {
        shouldPass(function () : void { Assert.notEqual(1, "1"); }); });
      requirement("asserting that an array does not equal a string should pass", function () : void {
        shouldPass(function () : void { Assert.notEqual([], ""); }); });

      (function () : void {
        const entity : Entity = new Entity;

        requirement("asserting equality of same entity should pass", function () : void {
          shouldPass(function () : void { Assert.equal(entity, entity); }); });
        requirement("asserting equality of different entities should fail", function () : void {
          shouldFail(function () : void { Assert.equal(new Entity, new Entity); }); });

        requirement("asserting non-equality of same entity should fail", function () : void {
          shouldFail(function () : void { Assert.notEqual(entity, entity); }); });
        requirement("asserting non-equality of different entities should pass", function () : void {
          shouldPass(function () : void { Assert.notEqual(new Entity, new Entity); }); });
      })();

      requirement("asserting equality of equal values should pass", function () : void {
        shouldPass(function () : void { Assert.equal(new Value(1), new Value(1)); }); });
      requirement("asserting equality of different values should fail", function () : void {
        shouldFail(function () : void { Assert.equal(new Value(1), new Value(2)); }); });

      (function () : void {
        const expected : Object = new CaseInsensitiveString("foo");
        const equal : Object = new CaseInsensitiveString("FOO");
        const different : Object = new CaseInsensitiveString("bar");

        requirement("asserting non-equality of different values should pass", function () : void {
          shouldPass(function () : void { Assert.notEqual(expected, different); }); });
        requirement("asserting non-equality of equal values should fail", function () : void {
          shouldFail(function () : void { Assert.notEqual(expected, equal); }); });

        const error : AssertionError
          = getError(function () : void { Assert.notEqual(expected, equal); });

        requirement("non-equality message should include expected value", function () : void {
          assert(Text.contains(error.message, expected.value),
            "was »" + error.message + "«"); });
        requirement("non-equality message should include actual value", function () : void {
          assert(Text.contains(error.message, equal.value),
            "was »" + error.message + "«"); });
      })();

      requirement("asserting a value equals either nothing should not work", function () : void {
        shouldThrow(function () : void { Assert.equalsEither([], "foo"); }, ArgumentError); });
      requirement("asserting a value equals either itself should pass", function () : void {
        shouldPass(function () : void { Assert.equalsEither(["foo"], "foo"); }); });
      requirement("asserting a value equals either an equal value should pass", function () : void {
        shouldPass(function () : void { Assert.equalsEither([new Value(0)], new Value(0)); }); });
      requirement("asserting a value equals either another value should fail", function () : void {
        shouldFail(function () : void { Assert.equalsEither(["bar"], "foo"); }); });
      requirement("asserting a number equals either itself stringified should fail", function () : void {
        shouldFail(function () : void { Assert.equalsEither(["0"], 0); }); });
      requirement("asserting a value equals either itself or another value should pass", function () : void {
        shouldPass(function () : void { Assert.equalsEither(["foo", "bar"], "foo"); }); });
      requirement("asserting a value equals either another value or itself should pass", function () : void {
        shouldPass(function () : void { Assert.equalsEither(["bar", "foo"], "foo"); }); });
      requirement("asserting a value equals either something or something else should fail", function () : void {
        shouldFail(function () : void { Assert.equalsEither(["bar", "baz"], "foo"); }); });

      (function () : void {
        const expected1 : String = "foo";
        const expected2 : String = "bar";
        const actual : String = "baz";

        const error : AssertionError
          = getError(function () : void { Assert.equalsEither([expected1, expected2], actual); });

        requirement("either-equality message should include first expected value", function () : void {
          assert(Text.contains(error.message, expected1),
            "was »" + error.message + "«"); });
        requirement("either-equality message should include second expected value", function () : void {
          assert(Text.contains(error.message, expected2),
            "was »" + error.message + "«"); });
        requirement("either-equality message should include actual value", function () : void {
          assert(Text.contains(error.message, actual),
            "was »" + error.message + "«"); });
      })();
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
