package org.asspec.util.sequences
{
  public class ArraySequenceContainerSlot implements SequenceContainerSlot
  {
    private var container : ArraySequenceContainer;
    private var index : int;

    public function ArraySequenceContainerSlot
      (container : ArraySequenceContainer, index : int)
    {
      this.container = container;
      this.index = index;
    }

    public function get hasValue() : Boolean
    { return container.hasIndex(index); }

    public function get value() : *
    { return container.get(index); }

    public function set value(value : *) : void
    { container.set(index, value); }

    public function remove() : void
    { container.removeAt(index); }
  }
}
