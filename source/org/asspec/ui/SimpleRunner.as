package org.asspec.ui
{
  import flash.display.Sprite;
  import flash.events.TimerEvent;
  import flash.external.ExternalInterface;
  import flash.system.System;
  import flash.utils.Timer;
  import flash.utils.getTimer;

  import org.asspec.AssertionError;
  import org.asspec.SizedTest;
  import org.asspec.Test;
  import org.asspec.basic.TestFailure;
  import org.asspec.basic.TestResult;
  import org.asspec.ui.stacktraces.StackTrace;
  import org.asspec.ui.stacktraces.StackTraceLine;

  public class SimpleRunner extends Sprite
  {
    private static function formatPattern(pattern : Array) : String
    {
      var result : String = "";

      for (var i : uint = 0; i < pattern.length; ++i)
        {
          if (i >= 80 && i % 80 == 0)
            result += "\n";

          if (pattern[i] == true)
            result += ".";
          else
            result += "F";
        }

      return result;
    }

    private function getExpectedSize(test : Test, result : TestResult) : uint
    {
      if (test is SizedTest)
        return SizedTest(test).size;
      else
        return result.numTests;
    }

    private var t0 : int;

    private function get elapsedTime() : String
    { return Math.round((getTimer() - t0) / 1000 * 100) / 100 + " seconds"; }

    public function SimpleRunner(test : Test)
    {
      const result : TestResult = new TestResult;

      t0 = getTimer();

      test.run(result);

      if (result.numFailures == 0)
        {
          const expectedSize : uint = getExpectedSize(test, result);
          const actualSize : uint = result.numTests;

          if (expectedSize >= actualSize)
            trace("Ran " + actualSize + " tests.");
          else if (expectedSize < actualSize)
            trace("Ran " + actualSize + " tests "
                  + "(" + (actualSize - expectedSize) + " new).");

          if (actualSize >= expectedSize)
            trace("OK (took " + elapsedTime + ").");
          else
            trace("Expected " + expectedSize + ", so missing "
                  + (expectedSize - actualSize) + " tests!");
        }
      else
        {
          trace("Ran " + result.numTests + " tests, "
                + "but " + result.numFailures + " failed!")

          trace(formatPattern(result.pattern));

          for each (var failure : TestFailure in result.failures)
            {
              trace("");
              trace("Failure: " + failure.test);

              if (failure.error is AssertionError)
                trace("  (" + failure.error.message + ")");
              else if (failure.error != null)
                trace(getStackTrace(failure.error));
            }
        }

      exit(result.numFailures == 0 ? 0 : 1);
    }

    private static function getStackTrace(error : Error) : StackTrace
    { return StackTrace.fromError(error).cutoffBefore(isCutoffLine); }

    private static function isCutoffLine(line : StackTraceLine) : Boolean
    { return line.methodName.match(/\$\$\$beginTest\$\$\$/) != null; }

    private static function exit(status : uint) : void
    {
      const timer : Timer = new Timer(100, 1);

      timer.addEventListener(TimerEvent.TIMER,
        function () : void { exitNow(status) });

      timer.start();
    }

    private static function exitNow(status : uint) : void
    {
      try
        { System.exit(status); }
      catch (error : Error)
        {
          if (ExternalInterface.available)
            try
              { ExternalInterface.call("window.close"); }
            catch (error : Error)
              {}
        }
    }
  }
}
