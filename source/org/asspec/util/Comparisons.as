package org.asspec.util
{
  public class Comparisons
  {
    public static function equal(a : Object, b : Object) : Boolean
    {
      if (a is EqualityComparable)
        return EqualityComparable(a).equals(b);
      else if (a is Array && b is Array)
        return arraysEqual(a as Array, b as Array);
      else
        return a === b;
    }

    private static function arraysEqual(a : Array, b : Array) : Boolean
    { return a.length == b.length && arrayContentsEqual(a, b); }

    private static function arrayContentsEqual(a : Array, b : Array) : Boolean
    {
      for (var i : uint = 0; i < a.length; ++i)
        if (!equal(a[i], b[i]))
          return false;

      return true;
    }
  }
}
