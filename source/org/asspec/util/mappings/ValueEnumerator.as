package org.asspec.util.mappings
{
  public class ValueEnumerator extends AbstractEnumerator
  {
    public function ValueEnumerator(container : ArrayMappingContainer)
    { super(container); }

    override protected function getValue(pair : Pair) : Object
    { return pair.value; }
  }
}
