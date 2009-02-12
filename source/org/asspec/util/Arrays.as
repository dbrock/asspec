package org.asspec.util
{
  public class Arrays
  {
    public static function wrap(object : Object) : Array
    { return object is Array ? object as Array : [object]; }
  }
}
