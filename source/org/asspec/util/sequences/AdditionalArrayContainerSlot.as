package org.asspec.util.sequences
{
  public class AdditionalArrayContainerSlot implements SequenceContainerSlot
  {
    private var container : ArrayContainer;
    private var realized : Boolean = false;
    private var index : int;

    public function AdditionalArrayContainerSlot
      (container : ArrayContainer)
    { this.container = container; }

    public function get hasValue() : Boolean
    { return realized && container.hasIndex(index); }

    public function get value() : *
    { return container.get(index); }

    public function set value(value : *) : void
    {
      realized = true;
      index = container.length;
      container.add(value);
    }

    public function remove() : void
    {
      if (realized)
        container.removeAt(index);
      else
        throw new ArgumentError;
    }
  }
}
