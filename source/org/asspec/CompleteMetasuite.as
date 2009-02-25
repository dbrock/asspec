package org.asspec
{
  import org.asspec.basic.SuiteMetaspecification;

  public class CompleteMetasuite implements SizedTest
  {
    public function get size() : uint { return 233; }

    public function run(listener : TestListener) : void
    {
      // Verify the suite specification first, since suites
      // are used to implement the rest of the specifications.
      new SuiteMetaspecification().run(listener);
      new MainMetasuite().run(listener);
    }
  }
}
