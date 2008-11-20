package org.asspec
{
  public interface TestListener
  {
    function testPassed(test : Test) : void;
    function testFailed(test : Test, error : Error) : void;
  }
}
