package org.asspec
{
  public class TestFailure
  {
    public var test : Test;
    public var error : Error;

    public function TestFailure(test : Test, error : Error)
    {
      this.test = test;
      this.error = error;
    }
  }
}
