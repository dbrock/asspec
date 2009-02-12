package org.asspec.spec
{
  import org.asspec.basic.Suite;

  public class SpecificationMetasuite extends Suite
  {
    override protected function populate() : void
    {
      add(new SpecificationMetaspecification);
      add(SpecificationSuite.forClass(ContextMetaspecification));
    }
  }
}
