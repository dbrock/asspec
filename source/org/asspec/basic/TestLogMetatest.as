package org.asspec.basic
{
  import org.asspec.AssertionError;
  import org.asspec.util.UnimplementedMethodError;

  public class TestLogMetatest extends NamedManualTest
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
        listener.handleTestPassed(this);
      else
        listener.handleTestFailed(this, assertionError);
    }

    private function get assertionError() : Error
    {
      return new AssertionError
        ("wrong log: expected »" + expectedLog + "« "
         + "but was »" + actualLog + "«");
    }
  }
}
