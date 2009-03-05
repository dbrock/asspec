package org.asspec.util.mappings
{
  import org.asspec.basic.AbstractSuite;

  public class MappingMetasuite extends AbstractSuite
  {
    override protected function populate() : void
    { addSpecification(ArrayMappingContainerMetaspecification); }
  }
}
