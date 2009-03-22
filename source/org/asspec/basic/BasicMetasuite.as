package org.asspec.basic
{
  import org.asspec.TestListener;

  public class BasicMetasuite extends AbstractSuite
  {
    override protected function populate() : void
    { addTest(new BasicTestMetaspecification); }
  }
}
