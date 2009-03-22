package org.asspec
{
  import org.asspec.util.EqualityComparable;
  import org.asspec.util.Reflection;

  public class Assert
  {
    public static function fail(message : String = null) : void
    { throw new AssertionError(message); }

    public static function that(test : Boolean) : void
    {
      if (!test)
        fail();
    }

    public static function notNull(actual : Object) : void
    { that(actual != null); }

    public static function equal
      (expected : Object, actual : Object) : void
    {
      if (!areEqual(expected, actual))
        throw getEqualityAssertionError(expected, actual);
    }

    public static function getEqualityAssertionError
      (expected : Object, actual : Object, prefix : String = "") : Error
    { return new AssertionError(prefix +
        "expected »" + Reflection.inspect(expected) + "« " +
        "but was »" + Reflection.inspect(actual) + "«"); }

    private static function areEqual(expected : Object, actual : Object) : Boolean
    {
      if (expected is EqualityComparable)
        return EqualityComparable(expected).equals(actual);
      else
        return expected === actual;
    }

    public static function notEqual
      (expected : Object, actual : Object) : void
    {
      if (areEqual(expected, actual))
        throw getNonEqualityAssertionError(expected, actual);
    }

    private static function getNonEqualityAssertionError
      (expected : Object, actual : Object) : Error
    { return new AssertionError(
        "expected something not equal to »" + Reflection.inspect(expected) + "« " +
        "but was »" + Reflection.inspect(actual) + "«"); }

    public static function equalsEither(expected : Array, actual : Object) : void
    {
      if (expected.length == 0)
        throw new ArgumentError("no expected values");
      else if (expected.length == 1)
        equal(expected[0], actual);
      else
        {
          for each (var element : Object in expected)
            if (areEqual(element, actual))
              return;

          throw getEqualsEitherAssertionError(expected, actual);
        }
    }

    private static function getEqualsEitherAssertionError
      (expected : Array, actual : Object) : Error
    {
      const parts : Array = [];

      for each (var element : Object in expected)
        parts.push("»" + Reflection.inspect(element) + "«");

      return new AssertionError(
        "expected either " + parts.join(" or ") + " " +
        "but was »" + Reflection.inspect(actual) + "«");
    }

    public static function throwsError(thunk : Function) : void
    {
      try
        { thunk(); }
      catch (error : Error)
        { return; }

      fail("did not throw anything");
    }

    public static function returnsNormally(thunk : Function) : void
    {
      try
        { thunk(); }
      catch (error : Error)
        { fail("threw " + Reflection.getLocalClassName(error) + " " +
            "with message »" + error.message + "«"); }
    }
  }
}
