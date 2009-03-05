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
        shouldPass(function () : void { assertThrows(genericThrowingFunction); }); });
      requirement("asserting that empty function throws should fail", function () : void {
        shouldFail(function () : void { assertThrows(returningFunction); }); });

      requirement("asserting that that empty function returns should pass", function () : void {
        shouldPass(function () : void { assertReturns(returningFunction); }); });
      requirement("asserting that throwing function returns should fail", function () : void {
        shouldFail(function () : void { assertReturns(genericThrowingFunction); }); });

      requirement("asserting that returning function throws specific error should fail", function () : void {
        shouldFail(function () : void { assertThrows(returningFunction, ArgumentError); }); });
      requirement("asserting that generic function throws specific error should fail", function () : void {
        shouldFail(function () : void { assertThrows(genericThrowingFunction, ArgumentError); }); });
      requirement("asserting that specific function throws specific error should pass", function () : void {
        shouldPass(function () : void { assertThrows(argumentErrorThrowingFunction, ArgumentError); }); });
    }

    private static function returningFunction() : void
    {}

    private static function genericThrowingFunction() : void
    { throw new Error; }

    private static function argumentErrorThrowingFunction() : void
    { throw new ArgumentError; }
  }
}
