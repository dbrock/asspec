package org.asspec.util
{
  import org.asspec.Assert;
  import org.asspec.spec.Specification;

  public class ArraySequenceSpecification extends Specification
  {
    override protected function execute() : void
    {
      it("should drop while",
        function () : void
        { Assert.equal(-3, new ArraySequence([1, 2, -3, -4]).dropWhile(positive).first); });
    }

    private static function positive(number : int) : Boolean
    { return number > 0; }
  }
}
