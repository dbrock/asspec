package org.asspec
{
  public class Assert
  {
    public static function fail(message : String = null) : void
    { throw new AssertionError(message); }

    public static function that(test : Boolean) : void
    {
      if (!test)
        fail();
    }

    public static function getEqualityAssertionError
      (expected : Object, actual : Object, prefix : String = "") : Error
    { return new AssertionError(prefix +
        "expected »" + expected + "« " +
        "but was »" + actual + "«"); }

    public static function equal
      (expected : Object, actual : Object) : void
    {
      if (expected != actual)
        throw getEqualityAssertionError(expected, actual);
    }

    public static function notNull(actual : Object) : void
    { that(actual != null); }

    public static function throwsError(thunk : Function) : void
    {
      try
        { thunk(); }
      catch (error : Error)
        { return; }

      fail();
    }

    public static function returnsNormally(thunk : Function) : void
    {
      try
        { thunk(); }
      catch (error : Error)
        { fail(); }
    }
  }
}
