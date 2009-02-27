package org.asspec.util.sequences
{
  import flash.utils.Proxy;
  import flash.utils.flash_proxy;

  import org.asspec.util.EqualityComparable;

  public class Sequence extends Proxy implements Sequencable
  {
    private var content : ArrayContainer;

    public function Sequence(content : Array)
    { this.content = new ArrayContainer(content); }

    public function equals(other : EqualityComparable) : Boolean
    { return content.equals(other); }

    // Inspection
    public function get empty() : Boolean
    { return content.empty; }

    public function get length() : uint
    { return content.length; }

    // Destruction
    public function get first() : *
    { return content.first; }

    public function get rest() : Sequence
    { return content.rest; }

    public function get last() : *
    { return content.last; }

    // Construction
    public function cons(element : Object) : Sequence
    { return content.cons(element); }

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

    // ----------------------------------------------------
    // Enumeration
    // ----------------------------------------------------
    override flash_proxy function nextNameIndex(index : int) : int
    { return content.flash_proxy::nextNameIndex(index); }

    override flash_proxy function nextValue(index : int) : *
    { return content.flash_proxy::nextValue(index); }
  }
}