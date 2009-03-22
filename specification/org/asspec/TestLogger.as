package org.asspec
{
  public class TestLogger implements TestListener
  {
    public var log : String = "";

    public function testPassed(test : Test) : void
    { log += "[" + test + " passed]"; }

    public function testFailed(test : Test, error : Error) : void
    { log += "[" + test + " failed]"; }

    public static function run(test : Test) : String
    {
      if (test is LoggingTest)
        return runLoggingTest(LoggingTest(test));
      else
        return runUnloggedTest(test);
    }

    private static function runLoggingTest(test : LoggingTest) : String
    {
      test.run(new NullTestListener)

      return test.log;
    }

    private static function runUnloggedTest(test : Test) : String
    {
      const result : TestLogger = new TestLogger;

      test.run(result);

      return result.log;
    }
  }
}
