package org.asspec.util.sequences
{
  public class AdditionalArraySequenceContainerSlot
    implements SequenceContainerSlot
  {
    private var container : ArraySequenceContainer;
    private var realized : Boolean = false;
    private var index : int;

    public function AdditionalArraySequenceContainerSlot
      (container : ArraySequenceContainer)
    { this.container = container; }

    public function get hasValue() : Boolean
    { return realized && container.hasIndex(index); }

    public function get value() : *
    {
      if (realized)
        return container.get(index);
      else
        throw new ArgumentError;
    }

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
