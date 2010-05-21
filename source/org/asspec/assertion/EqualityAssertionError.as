package org.asspec.assertion
{
  import org.asspec.AssertionError;

  public class EqualityAssertionError extends AssertionError
  {
    private var _expected : Object;
    private var _actual : Object;

    public function EqualityAssertionError
      (expected : Object, actual : Object)
    {
      super(getMessage(expected, actual));

      _expected = expected;
      _actual = actual;
    }

    public function get expected() : Object
    { return _expected; }

    public function get actual() : Object
    { return _actual; }

    private function getMessage
      (expected : Object, actual : Object) : String
    {
      return "expected " + inspect(expected) + " "
        + "but was " + inspect(actual);
    }
  }
}
