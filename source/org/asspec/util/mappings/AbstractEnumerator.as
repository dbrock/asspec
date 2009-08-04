package org.asspec.util.mappings
{
  import org.asspec.util.UnimplementedMethodError;
  import org.asspec.util.foreach.AbstractForeachable;
  import org.asspec.util.foreach.foreach_support;

  use namespace foreach_support;

  public class AbstractEnumerator extends AbstractForeachable
  {
    private var container : ArrayMappingContainer;

    public function AbstractEnumerator(container : ArrayMappingContainer)
    { this.container = container; }

    protected function getValue(pair : Pair) : Object
    { throw new UnimplementedMethodError; }

    override foreach_support function get length() : uint
    { return container.pairContainer.length; }

    override foreach_support function getElementAt(index : int) : Object
    { return getValue(Pair(container.pairContainer.get(index))); }
  }
}
