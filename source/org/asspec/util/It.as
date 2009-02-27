package org.asspec.util
{
  import org.asspec.equality.Equality;

  public class It
  {
    public static function equals(expected : Object) : Function
    {
      return function (actual : Object) : Boolean
        { return Equality.equals(actual, expected); };
    }
  }
}
