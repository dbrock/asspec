package org.asspec.util.sequences
{
  import org.asspec.util.foreach.Foreachable;

  public interface SequenceContainer extends Sequencable
  {
    function add(element : Object) : void;
    function set(index : int, value : Object) : void;
    function remove(element : Object) : void;
    function removeAt(index : int) : void;
    function clear() : void;
    function getSlotAt(index : int) : SequenceContainerSlot;
    function getAdditionalSlot() : SequenceContainerSlot;
    function get slots() : Foreachable;
    function set content(value : Sequencable) : void;
  }
}
