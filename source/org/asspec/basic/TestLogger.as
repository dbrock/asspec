package org.asspec.basic
{
  import org.asspec.Test;
  import org.asspec.TestListener;

  public class TestLogger implements TestListener
  {
    public var log : String = "";

    public function testPassed(test : Test) : void
    { log += "[" + test + " passed]"; }

    public function testFailed(test : Test, error : Error) : void
    { log += "[" + test + " failed]"; }

    // ----------------------------------------------------

    public static function run(test : Test) : String
    {
      const result : TestLogger = new TestLogger;

      test.run(result);

      return result.log;
    }
  }
}
