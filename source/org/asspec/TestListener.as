package org.asspec
{
  public interface TestListener
  {
    function handleTestStarted(test : Test) : void;
    function handleTestPassed(test : Test) : void;
    function handleTestFailed(test : Test, error : Error) : void;
  }
}
