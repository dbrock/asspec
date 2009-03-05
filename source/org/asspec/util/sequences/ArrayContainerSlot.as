package org.asspec.util.sequences
{
  public class ArrayContainerSlot implements SequenceContainerSlot
  {
    private var container : ArrayContainer;
    private var index : int;

    public function ArrayContainerSlot
      (container : ArrayContainer, index : int)
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
