package org.asspec.util.mappings
{
  import org.asspec.equality.Equality;
  import org.asspec.util.EqualityComparable;

  public class Pair implements EqualityComparable
  {
    private var _key : Object;
    private var _value : Object;

    public function Pair(key : Object, value : Object)
    {
      _key = key;
      _value = value;
    }

    public function equals(other : EqualityComparable) : Boolean
    {
      return other is Pair
        && Equality.equals(Pair(other).key, key)
        && Equality.equals(Pair(other).value, value);
    }

    public function get key() : *
    { return _key; }

    public function get value() : *
    { return _value; }

    public static function of(key : Object, value : Object) : Pair
    { return new Pair(key, value); }
  }
}
