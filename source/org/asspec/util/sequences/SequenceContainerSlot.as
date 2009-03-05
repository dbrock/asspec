package org.asspec.util.sequences
{
  public interface SequenceContainerSlot
  {
    function get hasValue() : Boolean;
    function get value() : *;
    function set value(value : *) : void;
    function remove() : void;
  }
}
