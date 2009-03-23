package org.asspec.util.sequences
{
  import org.asspec.util.EqualityComparable;

  public interface Sequencable extends EqualityComparable
  {
    // Inspection
    function get empty() : Boolean;
    function get length() : uint;
    function hasIndex(index : int) : Boolean;
    function contains(element : Object) : Boolean;
    function getIndexOf(element : Object) : uint;

    // Destruction
    function get first() : *;
    function get rest() : Sequence;
    function get last() : *;
    function get(index : int) : *;

    // Construction
    function cons(element : Object) : Sequence;
    function snoc(element : Object) : Sequence;

    // Transformation
    function map(transform : Function) : Sequence;

    // Iteration
    function forEach(callback : Function) : void;

    // Selection
    function filter(predicate : Function) : Sequence;
    function takeWhile(predicate : Function) : Sequence;
    function dropWhile(predicate : Function) : Sequence;
    function takeUntil(predicate : Function) : Sequence;
    function dropUntil(predicate : Function) : Sequence;

    // Special-purpose catamorphisms
    function any(predicate : Function) : Boolean;
    function all(predicate : Function) : Boolean;
    function join(delimiter : String) : String;

    // Type checking
    function ensureNullableType(type : Class) : void;
    function ensureType(type : Class) : void;

    // Conversion
    function get sequence() : Sequence;
    function getArrayCopy() : Array;
  }
}
