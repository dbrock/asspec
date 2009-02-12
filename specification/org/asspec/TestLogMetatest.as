package org.asspec
{
  import org.asspec.basic.NamedPristineTest;
  import org.asspec.util.UnimplementedMethodError;

  public class TestLogMetatest extends NamedPristineTest
  {
    protected var actualLog : String;

    protected function runTest() : void
    { throw new UnimplementedMethodError; }
    protected function get expectedLog() : String
    { throw new UnimplementedMethodError; }

    override protected function execute() : void
    {
      runTest();
      verifyLog();
    }

    private function verifyLog() : void
    {
      if (actualLog == expectedLog)
        listener.testPassed(this);
      else
        listener.testFailed(this, assertionError);
    }

    private function get assertionError() : Error
    { return Assert.getEqualityAssertionError
        (expectedLog, actualLog, "wrong log: "); }
  }
}
