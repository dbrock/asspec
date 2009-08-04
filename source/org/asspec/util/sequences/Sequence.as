package org.asspec.util.sequences
{
  import org.asspec.util.EqualityComparable;
  import org.asspec.util.foreach.AbstractForeachable;
  import org.asspec.util.foreach.foreach_support;

  use namespace foreach_support;

  public class Sequence extends AbstractForeachable
    implements Sequencable
  {
    private var content : ArraySequenceContainer;

    public function Sequence(content : Array)
    { this.content = new ArraySequenceContainer(content); }

    public function equals(other : EqualityComparable) : Boolean
    { return content.equals(other); }

    // Inspection
    public function get empty() : Boolean
    { return content.empty; }

    public function get length() : uint
    { return content.public::length; }

    public function hasIndex(index : int) : Boolean
    { return content.hasIndex(index); }

    public function contains(element : Object) : Boolean
    { return content.contains(element); }

    public function getIndexOf(element : Object) : uint
    { return content.getIndexOf(element); }

    // Destruction
    public function get first() : *
    { return content.first; }

    public function get rest() : Sequence
    { return content.rest; }

    public function get last() : *
    { return content.last; }

    public function get(index : int) : *
    { return content.get(index); }

    // Construction
    public function cons(element : Object) : Sequence
    { return content.cons(element); }

    public function snoc(element : Object) : Sequence
    { return content.snoc(element); }

    // Transformation
    public function map(transform : Function) : Sequence
    { return content.map(transform); }

    // Iteration
    public function forEach(callback : Function) : void
    { return content.forEach(callback); }

    // Selection
    public function filter(predicate : Function) : Sequence
    { return content.filter(predicate); }

    public function takeWhile(predicate : Function) : Sequence
    { return content.takeWhile(predicate); }

    public function dropWhile(predicate : Function) : Sequence
    { return content.dropWhile(predicate); }

    public function takeUntil(predicate : Function) : Sequence
    { return content.takeUntil(predicate); }

    public function dropUntil(predicate : Function) : Sequence
    { return content.dropUntil(predicate); }

    // Special-purpose catamorphisms
    public function any(predicate : Function) : Boolean
    { return content.any(predicate); }

    public function all(predicate : Function) : Boolean
    { return content.all(predicate); }

    public function join(delimiter : String) : String
    { return content.join(delimiter); }

    // Type checking
    public function ensureNullableType(type : Class) : void
    { return content.ensureNullableType(type); }

    public function ensureType(type : Class) : void
    { return content.ensureType(type); }

    // Conversion
    public function get sequence() : Sequence
    { return this; }

    public function getArrayCopy() : Array
    { return content.getArrayCopy(); }

    public function toString() : String
    { return content.toString(); }

    public static function fromArray(array : Array) : Sequence
    { return new Sequence(array.concat()); }

    public static function of(... elements : Array) : Sequence
    { return new Sequence(elements); }

    // ----------------------------------------------------
    // Enumeration
    // ----------------------------------------------------
    override foreach_support function get length() : uint
    { return length; }

    override foreach_support function getElementAt(index : int) : Object
    { return get(index); }
  }
}
