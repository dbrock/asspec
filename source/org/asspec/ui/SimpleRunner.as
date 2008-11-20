package org.asspec.ui
{
  import flash.display.Sprite;
  import flash.events.TimerEvent;
  import flash.system.System;
  import flash.utils.Timer;

  import org.asspec.AssertionError;
  import org.asspec.SizedTest;
  import org.asspec.Test;
  import org.asspec.TestFailure;
  import org.asspec.TestResult;
  import org.asspec.util.StackTrace;
  import org.asspec.util.StackTraceLine;

  public class SimpleRunner extends Sprite
  {
    private static function formatPattern(pattern : Array) : String
    {
      var result : String = "";

      for each (var testResult : Boolean in pattern)
        if (testResult == true)
          result += ".";
        else
          result += "F";

      return result;
    }

    private function getExpectedSize(test : Test, result : TestResult) : uint
    {
      if (test is SizedTest)
        return SizedTest(test).size;
      else
        return result.numTests;
    }

    public function SimpleRunner(test : Test)
    {
      const result : TestResult = new TestResult;

      test.run(result);

      if (result.numFailures == 0)
        {
          const expectedSize : uint = getExpectedSize(test, result);
          const actualSize : uint = result.numTests;

          if (expectedSize >= actualSize)
            trace("Ran " + actualSize + " tests.");
          else if (expectedSize < actualSize)
            trace("Ran " + actualSize + " tests (" + (actualSize - expectedSize) + " new).");

          if (actualSize >= expectedSize)
            trace("OK.");
          else
            trace("Expected " + expectedSize + ", so " + (expectedSize - actualSize) + " missing!");

          exit(0);
        }
      else
        {
          trace("Ran " + result.numTests + " tests, but " + result.numFailures + " failed!")
          trace(formatPattern(result.pattern));

          for each (var failure : TestFailure in result.failures)
            {
              trace("");
              trace("Failure: " + failure.test.name);

              if (failure.error is AssertionError)
                trace("  (" + failure.error.message + ")");
              else if (failure.error != null)
                trace(getStackTrace(failure.error));
            }

          exit(1);
        }
    }

    private static function getStackTrace(error : Error) : StackTrace
    { return StackTrace.fromError(error).cutoffBefore(isCutoffLine); }

    private static function isCutoffLine(line : StackTraceLine) : Boolean
    { return line.methodName.match(/\$\$\$beginTest\$\$\$/) != null; }

    private static function exit(status : uint) : void
    {
      const timer : Timer = new Timer(0);
      timer.addEventListener(TimerEvent.TIMER,
        function () : void { System.exit(status); });
      timer.start();
    }
  }
}
