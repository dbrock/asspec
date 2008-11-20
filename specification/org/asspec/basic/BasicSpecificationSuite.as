package org.asspec.basic
{
  import org.asspec.TestListener;

  public class BasicSpecificationSuite extends Suite
  {
    override protected function populate() : void
    {
      add(new SuiteSpecification);
      add(new PassingTestSpecification);
      add(new FailingTestSpecification);
    }
  }
}
