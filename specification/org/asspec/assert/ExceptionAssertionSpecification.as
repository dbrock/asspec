package org.asspec.assert
{
  import org.asspec.Assert;

  public class ExceptionAssertionSpecification extends TestSpecification
  {
    override protected function execute() : void
    {
      requirement("test passes assertion that bomb function throws error",
        function () : void
        { shouldPass(bombThrowsError); });

      requirement("test breaks by assertion that empty function throws error",
        function () : void
        { shouldFail(emptyThrowsError); });

      requirement("test passes assertion that empty function returns normally",
        function () : void
        { shouldPass(emptyReturnsNormally); });

      requirement("test breaks by assertion that bomb function returns normally",
        function () : void
        { shouldFail(bombReturnsNormally); });
    }

    private static function bombThrowsError() : void
    { Assert.throwsError(bomb); }
    private static function emptyThrowsError() : void
    { Assert.throwsError(empty); }
    private static function emptyReturnsNormally() : void
    { Assert.returnsNormally(empty); }
    private static function bombReturnsNormally() : void
    { Assert.returnsNormally(bomb); }

    private static function empty() : void {}
    private static function bomb() : void { throw new Error; }
  }
}
