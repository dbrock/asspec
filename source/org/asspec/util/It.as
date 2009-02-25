package org.asspec.util
{
  import org.asspec.equality.equal;

  public class It
  {
    public static function equals(expected : Object) : Function
    {
      return function (actual : Object) : Boolean
        { return equal(actual, expected); };
    }
  }
}
