package org.asspec
{
  import org.asspec.basic.AbstractSuiteMetaspecification;

  public class CompleteMetasuite implements SizedTest
  {
    public function get size() : uint { return 324; }

    public function run(listener : TestListener) : void
    {
      // Verify the suite specification first, since suites
      // are used to implement the rest of the specifications.
      new AbstractSuiteMetaspecification().run(listener);
      new MainMetasuite().run(listener);
    }
  }
}
