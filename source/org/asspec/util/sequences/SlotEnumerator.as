package org.asspec.util.sequences
{
  import org.asspec.util.foreach.AbstractForeachable;
  import org.asspec.util.foreach.foreach_support;

  use namespace foreach_support;

  public class SlotEnumerator extends AbstractForeachable
  {
    private var container : SequenceContainer;

    public function SlotEnumerator(container : SequenceContainer)
    { this.container = container; }

    override foreach_support function get length() : uint
    { return container.length; }

    override foreach_support function getElementAt(index : int) : Object
    { return container.getSlotAt(index); }
  }
}
