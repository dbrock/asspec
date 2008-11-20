package org.asspec
{
  public class NullTestListener implements TestListener
  {
    public function testPassed(test : Test) : void
    {}

    public function testFailed(test : Test, error : Error) : void
    {}
  }
}
