package org.asspec.assertion
{
  import org.asspec.AssertionError;
  import org.asspec.specification.AbstractSpecification;
  import org.asspec.util.Reflection;
  import org.asspec.util.Text;

  public class AbstractAssertionMetaspecification extends AbstractSpecification
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
      const expectedName : String = Reflection.getLocalClassName(errorType);
      const actualName : String = Reflection.getLocalClassName(error);

      const message : String
        = "expected »" + expectedName + "« "
        + "but got »" + actualName + "«";

      assert(error is errorType, message);
    }

    protected static function shouldNotThrow(thunk : Function) : void
    {
      const error : Error = getError(thunk);
      const name : String = Reflection.getLocalClassName(error);

      assert(error == null, "expected no error but got »" + name + "«");
    }

    protected static function shouldContain
      (actual : String, expected : String) : void
    { assert(Text.of(actual).contains(expected), "was »" + actual + "«"); }

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
