package org.asspec.basic
{
  import org.asspec.Test;

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
