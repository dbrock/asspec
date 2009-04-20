package org.asspec.util.mappings
{
  import flash.utils.Proxy;
  import flash.utils.flash_proxy;

  import org.asspec.equality.Equality;
  import org.asspec.util.foreach.Foreachable;
  import org.asspec.util.sequences.ArraySequenceContainer;
  import org.asspec.util.sequences.SequenceContainer;
  import org.asspec.util.sequences.SequenceContainerSlot;

  public class ArrayMappingContainer extends Proxy
    implements MappingContainer
  {
    internal const pairContainer : SequenceContainer
      = new ArraySequenceContainer;

    public function has(key : Object) : Boolean
    { return getSlotFor(key).hasValue; }

    public function get(key : Object) : *
    { return Pair(getSlotFor(key).value).value; }

    public function set(key : Object, value : Object) : void
    { getSlotFor(key).value = Pair.of(key, value); }

    public function remove(key : Object) : void
    { getSlotFor(key).remove(); }

    public function clear() : void
    { pairContainer.clear(); }

    private function getSlotFor(key : Object) : SequenceContainerSlot
    {
      for each (var slot : SequenceContainerSlot in pairContainer.slots)
        if (Equality.equals(Pair(slot.value).key, key))
          return slot;

      return pairContainer.getAdditionalSlot();
    }

    public function get keys() : Foreachable
    { return new KeyEnumerator(this); }

    public function get values() : Foreachable
    { return new ValueEnumerator(this); }

    public function get pairs() : Foreachable
    { return new PairEnumerator(this); }

    override flash_proxy function nextNameIndex(index : int) : int
    { throw new Error("Please use .keys, .values, or .pairs to iterate."); }
  }
}
