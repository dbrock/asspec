package org.asspec.util
{
  import org.asspec.specification.AbstractSpecification;
  import org.asspec.specify;

  public class CurryMetaspecification extends AbstractSpecification
  {
    override protected function execute() : void
    {
      it("should concatenate the arguments", function () : void {
        specify(curry(makeArray, 1, 2)(3, 4)).should.equal([1, 2, 3, 4]); });
    }

    private static function makeArray(... elements : Array) : Array
    { return elements; }
  }
}
