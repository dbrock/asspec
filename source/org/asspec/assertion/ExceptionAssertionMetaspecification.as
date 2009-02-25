package org.asspec.assertion
{
  import org.asspec.classic.assertReturns;
  import org.asspec.classic.assertThrows;

  public class ExceptionAssertionMetaspecification
    extends AbstractAssertionMetaspecification
  {
    override protected function execute() : void
    {
      requirement("asserting that throwing function throws should pass", function () : void {
        shouldPass(function () : void { assertThrows(throwingFunction); }); });

      requirement("asserting that empty function throws should fail", function () : void {
        shouldFail(function () : void { assertThrows(returningFunction); }); });

      requirement("asserting that that empty function returns should pass", function () : void {
        shouldPass(function () : void { assertReturns(returningFunction); }); });

      requirement("asserting that throwing function returns should fail", function () : void {
        shouldFail(function () : void { assertReturns(throwingFunction); }); });
    }

    private static function returningFunction() : void {}
    private static function throwingFunction() : void { throw new Error; }
  }
}
