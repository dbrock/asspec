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

  public class ArraySequenceContainer extends AbstractForeachable
    implements SequenceContainer
  {
    private var array : Array;

    public function ArraySequenceContainer(array : Array = null)
    { this.array = array || []; }

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
        if (!Equality.equals(element, array[i++]))
          return false;

      return true;
    }

    // ----------------------------------------------------
    // Inspection
    // ----------------------------------------------------

    public function get empty() : Boolean
    { return length == 0; }

    public function get length() : uint
    { return array.length; }

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
        return new Sequence(array.slice(1));
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

      return array[index];
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
      const array : Array = getArrayCopy();

      array.unshift(element);

      return new Sequence(array);
    }

    public function snoc(element : Object) : Sequence
    {
      const array : Array = getArrayCopy();

      array.push(element);

      return new Sequence(array);
    }

    // ----------------------------------------------------
    // Transformation
    // ----------------------------------------------------

    public function map(transform : Function) : Sequence
    {
      const result : Array = [];

      for each (var element : Object in array)
        result.push(transform(element));

      return new Sequence(result);
    }

    // ----------------------------------------------------
    // Iteration
    // ----------------------------------------------------

    public function forEach(callback : Function) : void
    {
      for each (var element : Object in array)
        callback(element);
    }

    // ----------------------------------------------------
    // Selection
    // ----------------------------------------------------

    public function filter(predicate : Function) : Sequence
    {
      const result : Array = [];

      for each (var element : Object in array)
        if (predicate(element))
          result.push(element);

      return new Sequence(result);
    }

    public function takeWhile(predicate : Function) : Sequence
    {
      const result : Array = [];

      for each (var element : Object in array)
        if (predicate(element))
          result.push(element);
        else
          break;

      return new Sequence(result);
    }

    public function dropWhile(predicate : Function) : Sequence
    {
      var i : int;

      for (i = 0; i < array.length; ++i)
        if (!predicate(array[i]))
          break;

      return new Sequence(array.slice(i));
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
    { return map(inspectUnlessString).getArrayCopy().join(delimiter); }

    private static function inspectUnlessString(object : Object) : String
    {
      return object is String
        ? object as String
        : Inspection.inspect(object);
    }

    public function any(predicate : Function) : Boolean
    {
      for each (var element : Object in array)
        if (predicate(element))
          return true;

      return false;
    }

    public function all(predicate : Function) : Boolean
    {
      for each (var element : Object in array)
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
    { return array.concat(); }

    public function toString() : String
    { return Inspection.inspect(array); }

    // ----------------------------------------------------
    // Mutation
    // ----------------------------------------------------

    public function set content(value : Sequencable) : void
    { array = value.getArrayCopy(); }

    public function add(element : Object) : void
    { array.push(element); }

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
      array[index] = value;
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
      array.splice(index, 1);
    }

    public function remove(element : Object) : void
    { removeAt(getIndexOf(element)); }

    public function clear() : void
    { array = []; }

    public function getSlotAt(index : int) : SequenceContainerSlot
    { return new ArraySequenceContainerSlot(this, index); }

    public function getAdditionalSlot() : SequenceContainerSlot
    { return new AdditionalArraySequenceContainerSlot(this); }

    public function get slots() : Foreachable
    { return new SlotEnumerator(this); }

    // ----------------------------------------------------
    // Enumeration
    // ----------------------------------------------------

    override foreach_support function get length() : uint
    { return length; }

    override foreach_support function getElementAt(index : uint) : Object
    { return array[index]; }
  }
}
