package org.asspec.util.mappings
{
  public class KeyEnumerator extends AbstractEnumerator
  {
    public function KeyEnumerator(container : ArrayMappingContainer)
    { super(container); }

    override protected function getValue(pair : Pair) : Object
    { return pair.key; }
  }
}
