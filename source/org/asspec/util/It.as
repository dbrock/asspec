package org.asspec.util
{
  public class It
  {
    public static function equals(expected : Object) : Function
    { return function (actual : Object) : Boolean { return actual == expected}; }
  }
}
