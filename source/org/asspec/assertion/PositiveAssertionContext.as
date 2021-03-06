package org.asspec.assertion
{
  import org.asspec.AssertionError;
  import org.asspec.equality.EqualitySubject;
  import org.asspec.specify;
  import org.asspec.util.Reflection;
  import org.asspec.util.inspection.Inspection;

  public class PositiveAssertionContext implements AssertionContext
  {
    private var actual : Object;

    public function PositiveAssertionContext(actual : Object)
    { this.actual = actual; }

    // ------------------------------------------------------------

    public function get not() : AssertionContext
    { return new NegativeAssertionContext(actual); }

    public function get hold() : Object
    {
      if (actual != true)
        fail();

      return null;
    }

    // ------------------------------------------------------------

    private function fail(message : String = null) : void
    { throw new AssertionError(message); }

    private function inspect(object : Object) : String
    { return "»" + Inspection.inspect(object) + "«"; }

    private function get actualSubject() : EqualitySubject
    { return EqualitySubject.of(actual); }

    // ------------------------------------------------------------

    public function be_the_same_object_as(expected : Object) : void
    {
      if (actual !== expected)
        fail("expected the instance " + inspect(expected) + " "
             + "but was " + inspect(actual));
    }

    public function equal(expected : Object) : void
    {
      if (!actualSubject.equals(expected))
        throw new EqualityAssertionError(expected, actual);
    }

    public function equal_either_of(... expected : Array) : void
    { equal_either_element_of(expected); }

    public function equal_either_element_of(expected : Array) : void
    {
      if (expected.length == 0)
        throw new ArgumentError("no expected values");
      else if (expected.length == 1)
        equal(expected[0]);
      else if (!actualSubject.equalsEither(expected))
        {
          const parts : Array = [];

          for each (var element : Object in expected)
            parts.push(inspect(element));

          fail("expected either " + parts.join(" or ") + " "
               + "but was " + inspect(actual));
        }
    }

    public function look_like(expected : String) : void
    { specify(Inspection.inspect(actual)).should.equal(expected); }

    public function contain(expected : String) : void
    {
      if ((actual as String).indexOf(expected) == -1)
        fail("expected " + inspect(actual)
             + " to contain " + inspect(expected));
    }

    // ------------------------------------------------------------

    public function be_between(lower : Number, upper : Number) : void
    {
      if (!(actual is Number))
        fail("expected number but was " + inspect(actual) + " "
             + "(" + Reflection.getLocalClassName(actual) + ")");
      else if (actual <= lower || actual >= upper)
        fail("expected number between " + lower + " and " + upper + " "
             + "but was " + actual);
    }

    // ------------------------------------------------------------

    public function get return_normally() : Object
    {
      try
        { (actual as Function)(); }
      catch (error : Error)
        {
          fail("threw " + Reflection.getLocalClassName(error) + " "
               + "with message »" + error.message + "«");
        }

      return null;
    }

    public function get throw_error() : Object
    {
      try
        { (actual as Function)(); }
      catch (error : Error)
        { return null; }

      fail("did not throw anything");

      return null;
    }

    public function throw_error_of_type(type : Class) : void
    {
      const expectedTypeName : String
        = Reflection.getLocalClassName(type);

      try
        { (actual as Function)(); }
      catch (error : Error)
        {
          if (error is type)
            return;
          else
            fail("expected " + expectedTypeName + " "
                 + "but threw " + Reflection.getLocalClassName(error) + " "
                 + "with message »" + error.message + "«");
        }

      fail("did not throw anything");
    }
  }
}
