package org.asspec.story
{
  import org.asspec.basic.Suite;
  import org.asspec.spec.SpecificationSuite;

  public class StorySuite extends Suite
  {
    override protected function populate() : void
    {
      add(SpecificationSuite.forClass(StanzaCompilerSpecification));
    }
  }
}
