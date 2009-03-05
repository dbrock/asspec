package org.asspec.util.sequences
{
  public interface SequenceContainer extends Sequencable
  {
    function add(element : Object) : void;
    function set(index : int, value : Object) : void;
    function removeAt(index : int) : void;
  }
}
