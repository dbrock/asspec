package org.asspec
{
  public interface TestListener
  {
    function handleTestPassed(test : Test) : void;
    function handleTestFailed(test : Test, error : Error) : void;
  }
}
