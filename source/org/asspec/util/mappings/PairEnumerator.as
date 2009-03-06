package org.asspec.util.mappings
{
  public class PairEnumerator extends AbstractEnumerator
  {
    public function PairEnumerator(container : ArrayMappingContainer)
    { super(container); }

    override protected function getValue(pair : Pair) : Object
    { return pair; }
  }
}
