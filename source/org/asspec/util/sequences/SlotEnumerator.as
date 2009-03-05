package org.asspec.util.sequences
{
  import flash.utils.Proxy;
  import flash.utils.flash_proxy;

  public class SlotEnumerator extends Proxy implements Foreachable
  {
    private var container : SequenceContainer;

    public function SlotEnumerator(container : SequenceContainer)
    { this.container = container; }

    override flash_proxy function nextNameIndex(index : int) : int
    { return index == container.length ? 0 : index + 1; }

    override flash_proxy function nextValue(index : int) : *
    { return container.getSlotAt(index - 1); }
  }
}
