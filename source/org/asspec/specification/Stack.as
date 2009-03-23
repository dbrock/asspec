package org.asspec.specification
{
  import org.asspec.util.sequences.Sequence;

  public interface Stack
  {
    function push(element : Object) : void;
    function pop() : void;
    function get elements() : Sequence;
  }
}
