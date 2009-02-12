package org.asspec
{
  import org.asspec.util.UnimplementedMethodError;

  public class SimpleTestLogMetatest extends TestLogMetatest
  {
    protected var test : Test;

    protected function createTest() : void
    { throw new UnimplementedMethodError; }

    override protected function runTest() : void
    {
      createTest();
      actualLog = TestLogger.run(test);
    }
  }
}
