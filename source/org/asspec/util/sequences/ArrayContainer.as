package org.asspec.util.sequences
{
  import flash.utils.Proxy;
  import flash.utils.flash_proxy;
  import flash.utils.getQualifiedClassName;

  import org.asspec.equality.Equality;
  import org.asspec.util.EqualityComparable;
  import org.asspec.util.curry;
  import org.asspec.util.inspection.Inspection;

  public class ArrayContainer extends Proxy implements SequenceContainer
  {
    private var content : Array;

    public function ArrayContainer(content : Array = null)
    { this.content = content || []; }

    // ----------------------------------------------------
    // Comparison
    // ----------------------------------------------------

    public function equals(other : EqualityComparable) : Boolean
    {
      return other is Sequencable
        && Sequencable(other).length == length
        && elementsEqual(Sequencable(other));
    }

    private function elementsEqual(other : Sequencable) : Boolean
    {
      var i : uint = 0;

      for each (var element : Object in other)
        if (!Equality.equals(element, content[i++]))
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

    public function contains(element : Object) : Boolean
    { return any(curry(Equality.equals, element)); }

    public function getIndexOf(element : Object) : uint
    {
      for (var i : uint = 0; i < length; ++i)
        if (Equality.equals(get(i), element))
          return i;

      throw new ArgumentError;
    }

    // ----------------------------------------------------
    // Destruction
    // ----------------------------------------------------
    public function get first() : *
    { return content[0]; }

    public function get rest() : Sequence
    { return new Sequence(content.slice(1)); }

    public function get last() : *
    { return empty ? null : content[content.length - 1]; }

    public function get(index : int) : *
    {
      if (index < 0)
        return get(index + length);
      else if (index < length)
        return content[index];
      else
        throw new ArgumentError;
    }

    // ----------------------------------------------------
    // Construction
    // ----------------------------------------------------
    public function cons(element : Object) : Sequence
    {
      const content : Array = getArrayCopy();

      content.unshift(element);

      return new Sequence(content);
    }

    // ----------------------------------------------------
    // Transformation
    // ----------------------------------------------------
    public function map(transform : Function) : Sequence
    {
      const result : Array = [];

      for each (var element : Object in content)
        result.push(transform(element));

      return new Sequence(result);
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

      return new Sequence(result);
    }

    public function takeWhile(predicate : Function) : Sequence
    {
      const result : Array = [];

      for each (var element : Object in content)
        if (predicate(element))
          result.push(element);
        else
          break;

      return new Sequence(result);
    }

    public function dropWhile(predicate : Function) : Sequence
    {
      var i : int;

      for (i = 0; i < content.length; ++i)
        if (!predicate(content[i]))
          break;

      return new Sequence(content.slice(i));
    }

    public function takeUntil(predicate : Function) : Sequence
    { return takeWhile(invert(predicate)); }

    public function dropUntil(predicate : Function) : Sequence
    { return dropWhile(invert(predicate)); }

    // Generic.
    private static function invert(predicate : Function) : Function
    {
      return function (... arguments : Array) : Boolean
        { return !predicate.apply(this, arguments); }
    }

    // ----------------------------------------------------
    // Special-purpose catamorphisms
    // ----------------------------------------------------
    public function join(delimiter : String) : String
    { return map(Inspection.inspect).getArrayCopy().join(delimiter); }

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
    public function ensureNullableType(type : Class) : void
    {
      for each (var element : Object in this)
        ensureElementHasNullableType(element, type);
    }

    protected function ensureElementHasNullableType
      (element : Object, type : Class) : void
    {
      if (element != null && !(element is type))
        throw new TypeError("elements must be of type "
          + getQualifiedClassName(type));
    }

    public function ensureType(type : Class) : void
    {
      for each (var element : Object in this)
        ensureElementHasType(element, type);
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
    public function get sequence() : Sequence
    { return new Sequence(getArrayCopy()); }

    public function getArrayCopy() : Array
    { return content.concat(); }

    public function toString() : String
    { return Inspection.inspect(content); }

    // ----------------------------------------------------
    // Mutation
    // ----------------------------------------------------
    public function add(element : Object) : void
    { content.push(element); }

    public function set(index : int, value : Object) : void
    {
      if (index < 0)
        set(index + length, value);
      else if (index < length)
        content[index] = value;
      else
        throw new ArgumentError;
    }

    public function removeAt(index : int) : void
    {
      if (index < 0)
        removeAt(index + length);
      else if (index < length)
        content.splice(index, 1);
      else
        throw new ArgumentError;
    }

    // ----------------------------------------------------
    // Enumeration
    // ----------------------------------------------------
    override flash_proxy function nextNameIndex(index : int) : int
    { return index == content.length ? 0 : index + 1; }

    override flash_proxy function nextValue(index : int) : *
    { return content[index - 1]; }
  }
}
