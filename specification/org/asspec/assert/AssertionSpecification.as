package org.asspec.assert
{
  import org.asspec.AssertionError;
  import org.asspec.CustomTestRunner;
  import org.asspec.spec.Specification;
  import org.asspec.util.Reflection;

  public class AssertionSpecification extends Specification
  {
    protected static function shouldPass(thunk : Function) : void
    { shouldNotThrow(thunk); }

    protected static function shouldFail
      (thunk : Function, errorType : Class = null) : void
    { shouldThrow(thunk, AssertionError); }

    protected static function shouldThrow
      (thunk : Function, errorType : Class) : void
    {
      const error : Error = getError(thunk);

      assert(error is errorType,
        "expected »" + Reflection.getLocalClassName(errorType) + "« " +
        "but got »" + Reflection.getLocalClassName(error) + "«");
    }

    protected static function shouldNotThrow(thunk : Function) : void
    {
      const error : Error = getError(thunk);

      assert(error == null,
        "expected no error but got »" + Reflection.getLocalClassName(error) + "«");
    }

    protected static function getError(thunk : Function) : *
    {
      try
        { thunk(); }
      catch (error : Error)
        { return error; }

      return null;
    }

    protected static function assert
      (expected : Boolean, message : String = null) : void
    {
      if (!expected)
        throw new AssertionError(message);
    }
  }
}
