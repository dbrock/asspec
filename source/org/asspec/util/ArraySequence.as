package org.asspec.util
{
  import flash.utils.Proxy;
  import flash.utils.flash_proxy;

  public class ArraySequence extends Proxy implements MutableSequence
  {
    private var content : Array;

    protected function similarSequence(content : Array) : ArraySequence
    { return new ArraySequence(content); }

    public function ArraySequence(content : Array = null)
    { this.content = content || []; }

    // ----------------------------------------------------
    // Comparison
    // ----------------------------------------------------

    public function equals(other : Object) : Boolean
    { return other is Sequence
        && Sequence(other).length == length
        && elementsEqual(Sequence(other)); }

    private function elementsEqual(other : Sequence) : Boolean
    {
      var i : uint = 0;

      for each (var element : Object in other)
        if (element !== content[i++])
          return false;

      return true;
    }

    // ----------------------------------------------------
    // Inspection
    // ----------------------------------------------------
    public function get empty() : Boolean
    { return length == 0; }

    public function get length() : uint
    { return content.length; }

    // ----------------------------------------------------
    // Destruction
    // ----------------------------------------------------
    public function get first() : *
    { return content[0]; }

    public function get rest() : Sequence
    { return similarSequence(content.slice(1)); }

    public function get last() : *
    { return empty ? null : content[content.length - 1]; }

    // ----------------------------------------------------
    // Construction
    // ----------------------------------------------------
    public function cons(element : Object) : Sequence
    {
      const content : Array = toArray();

      content.unshift(element);

      return similarSequence(content);
    }

    // ----------------------------------------------------
    // Transformation
    // ----------------------------------------------------
    public function map(transform : Function) : Sequence
    {
      const result : Array = [];

      for each (var element : Object in content)
        result.push(transform(element));

      return new ArraySequence(result);
    }

    // ----------------------------------------------------
    // Iteration
    // ----------------------------------------------------
    public function forEach(callback : Function) : void
    {
      for each (var element : Object in content)
        callback(element);
    }

    // ----------------------------------------------------
    // Selection
    // ----------------------------------------------------
    public function filter(predicate : Function) : Sequence
    {
      const result : Array = [];

      for each (var element : Object in content)
        if (predicate(element))
          result.push(element);

      return similarSequence(result);
    }

    public function takeWhile(predicate : Function) : Sequence
    {
      const result : Array = [];

      for each (var element : Object in content)
        if (predicate(element))
          result.push(element);
        else
          break;

      return similarSequence(result);
    }

    public function dropWhile(predicate : Function) : Sequence
    {
      var i : int;

      for (i = 0; i < content.length; ++i)
        if (!predicate(content[i]))
          break;

      return similarSequence(content.slice(i));
    }

    public function takeUntil(predicate : Function) : Sequence
    { return takeWhile(invert(predicate)); }

    public function dropUntil(predicate : Function) : Sequence
    { return dropWhile(invert(predicate)); }

    // Generic.
    private static function invert(predicate : Function) : Function
    { return function (... arguments : Array) : Boolean
             { return !predicate.apply(this, arguments); }; }

    // ----------------------------------------------------
    // Special-purpose catamorphisms
    // ----------------------------------------------------
    public function join(delimiter : String) : String
    { return content.join(delimiter); }

    public function any(predicate : Function) : Boolean
    {
      for each (var element : Object in content)
        if (predicate(element))
          return true;

      return false;
    }

    public function all(predicate : Function) : Boolean
    {
      for each (var element : Object in content)
        if (!predicate(element))
          return false;

      return true;
    }

    // ----------------------------------------------------
    // Type checking
    // ----------------------------------------------------
    public function ensureNullableType(type : Class) : Sequence
    {
      for each (var element : Object in this)
        ensureElementHasNullableType(element, type);

      return this;
    }

    protected function ensureElementHasNullableType
      (element : Object, type : Class) : void
    { type(element); }

    public function ensureType(type : Class) : Sequence
    {
      for each (var element : Object in this)
        ensureElementHasType(element, type);

      return this;
    }

    protected function ensureElementHasType
      (element : Object, type : Class) : void
    {
      ensureElementNotNull(element);
      ensureElementHasNullableType(element, type);
    }

    protected function ensureElementNotNull(element : Object) : void
    {
      if (element == null)
        throw new TypeError("null is not allowed");
    }

    // ----------------------------------------------------
    // Conversion
    // ----------------------------------------------------
    public function toArray() : Array
    { return content.concat(); }

    public function toString() : String
    { return "[" + join(", ") + "]"; }

    // ----------------------------------------------------
    // Mutation
    // ----------------------------------------------------
    public function add(element : Object) : void
    { content.push(element); }

    // ----------------------------------------------------
    // Enumeration
    // ----------------------------------------------------
    override flash_proxy function nextNameIndex(index : int) : int
    { return index == content.length ? 0 : index + 1; }

    override flash_proxy function nextValue(index : int) : *
    { return content[index - 1]; }
  }
}
