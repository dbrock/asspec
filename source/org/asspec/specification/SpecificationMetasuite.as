package org.asspec.specification
{
  import org.asspec.basic.AbstractSuite;

  public class SpecificationMetasuite extends AbstractSuite
  {
    override protected function populate() : void
    { addTest(new SpecificationMetaspecification); }
  }
}
