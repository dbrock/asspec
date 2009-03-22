package org.asspec.assert
{
  import org.asspec.Assert;
  import org.asspec.AssertionError;

  public class BasicAssertionSpecification extends AssertionSpecification
  {
    override protected function execute() : void
    {
      requirement("calling Assert.fail should fail", function () : void {
        shouldFail(Assert.fail); });

      requirement("asserting true should pass", function () : void {
        shouldPass(function () : void { Assert.that(true); }); });

      requirement("asserting false should fail", function () : void {
        shouldFail(function () : void { Assert.that(false); }); });
    }
  }
}
