package org.asspec.basic
{
  import org.asspec.TestListener;

  public class BasicMetasuite extends Suite
  {
    override protected function populate() : void
    {
      add(new SuiteMetaspecification);
      add(new PassingTestMetaspecification);
      add(new FailingTestMetaspecification);
    }
  }
}
