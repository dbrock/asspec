package org.asspec.basic
{
  import org.asspec.Test;
  import org.asspec.TestListener;

  public class NullTestListener implements TestListener
  {
    public function testPassed(test : Test) : void
    {}

    public function testFailed(test : Test, error : Error) : void
    {}
  }
}
