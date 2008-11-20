package org.asspec.util
{
  public interface Sequence
  {
    // Inspection
    function get empty() : Boolean;

    // Destruction
    function get first() : *;
    function get rest() : Sequence;
    function get last() : *;

    // Construction
    function cons(element : Object) : Sequence;

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
    function join(delimiter : String) : String;

    // Type checking
    function ensureNullableType(type : Class) : Sequence;
    function ensureType(type : Class) : Sequence;

    // Conversion
    function toArray() : Array;
  }
}
