package org.asspec.assert
{
  import org.asspec.Assert;

  public class ExceptionAssertionSpecification extends AssertionSpecification
  {
    override protected function execute() : void
    {
      requirement("asserting that throwing function throws should pass", function () : void {
        shouldPass(function () : void { Assert.throwsError(throwingFunction); }); });

      requirement("asserting that empty function throws should fail", function () : void {
        shouldFail(function () : void { Assert.throwsError(emptyFunction); }); });

      requirement("asserting that that empty function returns should pass", function () : void {
        shouldPass(function () : void { Assert.returnsNormally(emptyFunction); }); });

      requirement("asserting that throwing function returns should fail", function () : void {
        shouldFail(function () : void { Assert.returnsNormally(throwingFunction); }); });
    }

    private static function emptyFunction() : void {}
    private static function throwingFunction() : void { throw new Error; }
  }
}
