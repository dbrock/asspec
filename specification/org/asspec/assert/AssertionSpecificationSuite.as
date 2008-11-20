package org.asspec.assert
{
  import org.asspec.basic.Suite;

  public class AssertionSpecificationSuite extends Suite
  {
    override protected function populate() : void
    {
      add(new BasicAssertionSpecification);
      add(new EqualityAssertionSpecification);
      add(new ExceptionAssertionSpecification);
    }
  }
}
