package org.asspec.assertion
{
  import org.asspec.AssertionError;
  import org.asspec.equality.Equality;
  import org.asspec.specify;
  import org.asspec.util.inspection.Inspection;

  public class NegativeAssertionContext implements AssertionContext
  {
    private var actual : Object;

    public function NegativeAssertionContext(actual : Object)
    { this.actual = actual; }

    public function get not() : AssertionContext
    { return new PositiveAssertionContext(actual); }

    public function get hold() : Object
    {
      if (actual != false)
        throw new AssertionError;

      return null;
    }

    public function be_the_same_object_as(expected : Object) : void
    {
      if (actual === expected)
        throw getNonIdentityAssertionError(expected);
    }

    private function getNonIdentityAssertionError(expected : Object) : Error
    {
      return new AssertionError
        ("expected another instance than " + inspect(expected));
    }

    private static function inspect(object : Object) : String
    { return "»" + Inspection.inspect(object) + "«"; }

    public function equal(expected : Object) : void
    {
      if (Equality.equals(actual, expected))
        throw getNonEqualityAssertionError(expected);
    }

    private function getNonEqualityAssertionError(expected : Object) : Error
    {
      return new AssertionError
        ("expected something not equal to " + inspect(expected) + " "
         + "but was " + inspect(actual));
    }

    public function equal_either_of(... expected : Array) : void
    { equal_either_element_of(expected); }

    public function equal_either_element_of(expected : Array) : void
    {
      if (expected.length == 0)
        throw new ArgumentError("no expected values");
      else if (expected.length == 1)
        equal(expected[0]);
      else
        {
          for each (var element : Object in expected)
            if (Equality.equals(actual, element))
              throw getEqualsNeitherAssertionError(expected, element);
        }
    }

    private function getEqualsNeitherAssertionError
      (expected : Array, equalExpected : Object) : Error
    {
      const parts : Array = [];

      for each (var element : Object in expected)
        parts.push(inspect(element));

      return new AssertionError
        ("expected neither " + parts.join(" nor ") + " "
         + "but was " + inspect(actual) + ", "
         + "which is equal to " + inspect(equalExpected));
    }

    public function look_like(expected : String) : void
    { specify(Inspection.inspect(actual)).should.not.equal(expected); }

    public function get return_normally() : Object
    { return not.throw_error; }

    public function get throw_error() : Object
    { return not.return_normally; }
  }
}
