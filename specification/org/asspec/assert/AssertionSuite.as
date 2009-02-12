package org.asspec.assert
{
  import org.asspec.basic.Suite;
  import org.asspec.spec.SpecificationSuite;

  public class AssertionSuite extends Suite
  {
    override protected function populate() : void
    {
      add(SpecificationSuite.forClass(BasicAssertionSpecification));
      add(SpecificationSuite.forClass(EqualityAssertionSpecification));
      add(SpecificationSuite.forClass(ExceptionAssertionSpecification));
    }
  }
}
