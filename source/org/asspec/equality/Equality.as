package org.asspec.equality
{
  public class Equality
  {
    public static function equals(a : Object, b : Object) : Boolean
    { return EqualitySubject.of(a).equals(b); }
  }
}
