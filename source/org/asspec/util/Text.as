package org.asspec.util
{
  public class Text
  {
    public static function lines(string : String) : Sequence
    { return new ArraySequence(string.split("\n")); }

    public static function contains
      (haystack : String, needle : String) : Boolean
    { return haystack.indexOf(needle) != -1; }
  }
}
