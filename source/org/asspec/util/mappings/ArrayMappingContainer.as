package org.asspec.util.mappings
{
  import org.asspec.equality.Equality;
  import org.asspec.util.sequences.ArrayContainer;
  import org.asspec.util.sequences.SequenceContainer;
  import org.asspec.util.sequences.SequenceContainerSlot;

  public class ArrayMappingContainer implements MappingContainer
  {
    private const pairs : SequenceContainer = new ArrayContainer;

    public function has(key : Object) : Boolean
    { return getSlotFor(key).hasValue; }

    public function get(key : Object) : *
    { return Pair(getSlotFor(key).value).value; }

    public function set(key : Object, value : Object) : void
    { getSlotFor(key).value = Pair.of(key, value); }

    public function remove(key : Object) : void
    { getSlotFor(key).remove(); }

    private function getSlotFor(key : Object) : SequenceContainerSlot
    {
      for each (var slot : SequenceContainerSlot in pairs.slots)
        if (Equality.equals(Pair(slot.value).key, key))
          return slot;

      return pairs.getAdditionalSlot();
    }
  }
}
