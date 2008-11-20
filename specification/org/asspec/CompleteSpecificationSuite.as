package org.asspec
{
  import org.asspec.basic.SuiteSpecification;

  public class CompleteSpecificationSuite implements SizedTest
  {
    public function get size() : uint { return 50; }
    public function get name() : String { return null; }

    public function run(listener : TestListener) : void
    {
      // Verify the suite specification first, since suites
      // are used to implement the rest of the specifications.
      new SuiteSpecification().run(listener);
      new MainSpecificationSuite().run(listener);
    }
  }
}
