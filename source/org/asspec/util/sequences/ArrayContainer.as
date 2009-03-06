package org.asspec.util.sequences
{
  import flash.utils.getQualifiedClassName;

  import org.asspec.equality.Equality;
  import org.asspec.util.EqualityComparable;
  import org.asspec.util.curry;
  import org.asspec.util.foreach.AbstractForeachable;
  import org.asspec.util.foreach.Foreachable;
  import org.asspec.util.foreach.foreach_support;
  import org.asspec.util.inspection.Inspection;

  use namespace foreach_support;

  public class ArrayContainer extends AbstractForeachable
    implements SequenceContainer
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

    public function hasIndex(index : int) : Boolean
    {
      if (index < 0)
        return $hasIndex(index + length);
      else
        return $hasIndex(index);
    }

    private function $hasIndex(index : int) : Boolean
    { return index >= 0 && index < length; }

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
    { return get(0); }

    public function get rest() : Sequence
    {
      if (empty)
        throw new ArgumentError;
      else
        return new Sequence(content.slice(1));
    }

    public function get last() : *
    { return get(-1); }

    public function get(index : int) : *
    {
      if (index >= 0)
        return $get(index);
      else
        return $get(index + length);
    }

    private function $get(index : int) : Object
    {
      validateIndex(index);

      return content[index];
    }

    private function validateIndex(index : int) : void
    {
      if (index < 0 || index >= length)
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
      if (index >= 0)
        $set(index, value);
      else
        $set(index + length, value);
    }

    private function $set(index : int, value : Object) : void
    {
      validateIndex(index);
      content[index] = value;
    }

    public function removeAt(index : int) : void
    {
      if (index >= 0)
        $removeAt(index);
      else
        $removeAt(index + length);
    }

    private function $removeAt(index : int) : void
    {
      validateIndex(index);
      content.splice(index, 1);
    }

    public function getSlotAt(index : int) : SequenceContainerSlot
    { return new ArrayContainerSlot(this, index); }

    public function getAdditionalSlot() : SequenceContainerSlot
    { return new AdditionalArrayContainerSlot(this); }

    public function get slots() : Foreachable
    { return new SlotEnumerator(this); }

    // ----------------------------------------------------
    // Enumeration
    // ----------------------------------------------------

    override foreach_support function get length() : uint
    { return length; }

    override foreach_support function getElementAt(index : uint) : Object
    { return content[index]; }
  }
}
