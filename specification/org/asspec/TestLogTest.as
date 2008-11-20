package org.asspec
{
  import org.asspec.basic.PristineTest;

  public class TestLogTest extends PristineTest
  {
    protected var test : Test;

    protected function createTest() : void {}
    protected function get expectedLog() : String { return null; }

    private var actualLog : String;

    override protected function execute() : void
    {
      createTest();
      runTest();
      verifyLog();
    }

    private function runTest() : void
    { actualLog = TestLogger.run(test); }

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
