package org.asspec.util
{
  import org.asspec.basic.Suite;
  import org.asspec.spec.SpecificationSuite;

  public class UtilitySuite extends Suite
  {
    override protected function populate() : void
    {
      add(SpecificationSuite.forClass(ArraysSpecification));
      add(SpecificationSuite.forClass(ArraySequenceSpecification));
      add(SpecificationSuite.forClass(ReflectionSpecification));
    }
  }
}
