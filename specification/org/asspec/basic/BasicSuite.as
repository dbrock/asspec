package org.asspec.basic
{
  import org.asspec.TestListener;

  public class BasicSuite extends Suite
  {
    override protected function populate() : void
    {
      add(new SuiteSpecification);
      add(new PassingTestSpecification);
      add(new FailingTestSpecification);
    }
  }
}
