package org.asspec.basic
{
  import org.asspec.Test;
  import org.asspec.TestListener;

  public class TestResult implements TestListener
  {
    public function get numSuccesses() : uint
    { return successes.length; }
    public function get numFailures() : uint
    { return failures.length; }

    public function get numTests() : uint
    { return numSuccesses + numFailures; }

    public var pattern : Array = [];
    public var successes : Array = [];
    public var failures : Array = [];

    public function testPassed(test : Test) : void
    {
      successes.push(test);
      pattern.push(true);
    }

    public function testFailed(test : Test, error : Error) : void
    {
      failures.push(new TestFailure(test, error));
      pattern.push(false);
    }

    public function get passed() : Boolean
    { return numFailures == 0; }
    public function get failed() : Boolean
    { return !passed; }

    public static function run(test : Test) : TestResult
    {
      const result : TestResult = new TestResult;

      test.run(result);

      return result;
    }

    public static function passes(test : Test) : Boolean
    { return run(test).passed; }

    public static function fails(test : Test) : Boolean
    { return !passes(test); }
  }
}
