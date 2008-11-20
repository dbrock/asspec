package org.asspec.assert
{
  import org.asspec.Assert;
  import org.asspec.AssertionError;
  import org.asspec.util.Text;

  public class EqualityAssertionSpecification extends TestSpecification
  {
    override protected function execute() : void
    {
      requirement("test should break when asserting that null is not null",
        function () : void
        { shouldFail(assertNullNotNull); });

      requirement("test should pass when asserting that null equals null",
        function () : void
        { shouldPass(assertNullEqualsNull); });

      requirement("test should breaks when asserting that different strings are equal",
        function () : void
        { shouldFail(assertFooEqualsBar); });

      requirement("equality assertions should throw AssertionError",
        function () : void
        { shouldThrow(assertFooEqualsBar, AssertionError); });

      requirement("equality assertion should give nice error message",
        function () : void
        {
          try
            { Assert.equal("foo", "bar"); }
          catch (error : Error)
            {
              assert(Text.contains(error.message, "foo"));
              assert(Text.contains(error.message, "bar"));
            }
        });
    }

    private static function assertNullNotNull() : void
    { Assert.notNull(null); }

    private static function assertNullEqualsNull() : void
    { Assert.equal(null, null); }

    private static function assertFooEqualsBar() : void
    { Assert.equal("foo", "bar"); }
  }
}
