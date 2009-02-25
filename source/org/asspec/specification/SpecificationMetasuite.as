package org.asspec.specification
{
  import org.asspec.basic.Suite;

  public class SpecificationMetasuite extends Suite
  {
    override protected function populate() : void
    { add(new SpecificationMetaspecification); }
  }
}
