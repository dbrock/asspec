package org.asspec.basic
{
  import org.asspec.Test;
  import org.asspec.TestListener;

  public class NullTestListener implements TestListener
  {
    public function handleTestStarted(test : Test) : void
    {}

    public function handleTestPassed(test : Test) : void
    {}

    public function handleTestFailed(test : Test, error : Error) : void
    {}
  }
}
