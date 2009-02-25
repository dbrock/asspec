package org.asspec.assertion
{
  import org.asspec.classic.assertTrue;
  import org.asspec.fail;

  public class BasicAssertionMetaspecification
    extends AbstractAssertionMetaspecification
  {
    override protected function execute() : void
    {
      requirement("calling fail should fail", function () : void {
        shouldFail(fail); });

      requirement("asserting true is true should pass", function () : void {
        shouldPass(function () : void { assertTrue(true); }); });

      requirement("asserting false is true should fail", function () : void {
        shouldFail(function () : void { assertTrue(false); }); });
    }
  }
}
