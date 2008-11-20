package org.asspec.assert
{
  import org.asspec.AssertionError;
  import org.asspec.CustomTestRunner;
  import org.asspec.spec.Specification;
  import org.asspec.util.Reflection;

  public class TestSpecification extends Specification
  {
    protected static function shouldPass(thunk : Function) : void
    { assert(CustomTestRunner.passes(thunk)); }

    protected static function shouldFail
      (thunk : Function, errorType : Class = null) : void
    { assert(CustomTestRunner.fails(thunk)); }

    protected static function shouldThrow
      (thunk : Function, errorType : Class) : void
    {
      const error : Error = CustomTestRunner.getError(thunk);

      assert(error is errorType,
        "expected »" + Reflection.getLocalClassName(errorType) + "« " +
        "but got »" + Reflection.getLocalClassName(error) + "«");
    }

    protected static function assert
      (expected : Boolean, message : String = null) : void
    {
      if (!expected)
        throw new AssertionError(message);
    }
  }
}
