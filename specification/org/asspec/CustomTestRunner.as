package org.asspec
{
  import org.asspec.basic.CustomTest;

  public class CustomTestRunner implements TestListener
  {
    private var _passed : Boolean = false;
    private var _failed : Boolean = false;
    private var _error : Error;

    public function testPassed(test : Test) : void
    { _passed = true; }
    public function testFailed(test : Test, error : Error) : void
    {
      _failed = true;
      _error = error;
    }

    public function get passed() : Boolean
    { return _passed && !failed; }
    public function get failed() : Boolean
    { return _failed; }
    public function get error() : Error
    { return _error; }

    public static function passes(implementation : Function) : Boolean
    { return run(implementation).passed; }
    public static function fails(implementation : Function) : Boolean
    { return run(implementation).failed; }
    public static function getError(implementation : Function) : Error
    { return run(implementation).error; }

    public static function run(implementation : Function) : CustomTestRunner
    {
      const result : CustomTestRunner = new CustomTestRunner;
      const test : Test = new CustomTest(implementation);

      test.run(result);

      return result;
    }
  }
}
