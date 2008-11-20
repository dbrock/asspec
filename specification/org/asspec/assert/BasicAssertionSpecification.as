package org.asspec.assert
{
  import org.asspec.Assert;
  import org.asspec.AssertionError;

  public class BasicAssertionSpecification extends TestSpecification
  {
    override protected function execute() : void
    {
      requirement("test should break when calling Assert.fail",
        function () : void
        { shouldFail(Assert.fail); });

      requirement("calling Assert.fail should throw AssertionError",
        function () : void
        { shouldThrow(Assert.fail, AssertionError); });

      requirement("test should pass when asserting true",
        function () : void
        { shouldPass(assertTrue); });

      requirement("test should break when asserting false",
        function () : void
        { shouldFail(assertFalse); });
    }

    private static function assertTrue() : void
    { Assert.that(true); }
    private static function assertFalse() : void
    { Assert.that(false); }
  }
}
