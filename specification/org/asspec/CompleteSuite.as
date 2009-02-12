package org.asspec
{
  import org.asspec.basic.SuiteSpecification;

  public class CompleteSuite implements SizedTest
  {
    public function get size() : uint { return 200; }

    public function run(listener : TestListener) : void
    {
      // Verify the suite specification first, since suites
      // are used to implement the rest of the specifications.
      new SuiteSpecification().run(listener);
      new MainSuite().run(listener);
    }
  }
}
