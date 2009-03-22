package org.asspec.util
{
  import org.asspec.Assert;
  import org.asspec.spec.Specification;

  public class ArraySequenceSpecification extends Specification
  {
    override protected function execute() : void
    {
      requirement("an empty sequence should stringify correctly", function () : void {
        Assert.equal("[]", new ArraySequence([]).toString()); });
      requirement("a sequence of numbers should stringify correctly", function () : void {
        Assert.equal("[1, 2, 3]", new ArraySequence([1, 2, 3]).toString()); });

      requirement("empty sequences should be equal", function () : void {
        Assert.equal(new ArraySequence([]), new ArraySequence([])); });
      requirement("equal primitive sequences should be equal", function () : void {
        Assert.equal(new ArraySequence([1, 2]), new ArraySequence([1, 2])); });
      requirement("different primitive sequences should not be equal", function () : void {
        Assert.notEqual(new ArraySequence([1, 2]), new ArraySequence([1, 1])); });
      requirement("a number sequence should not equal a string sequence", function () : void {
        Assert.notEqual(new ArraySequence([1]), new ArraySequence(["1"])); });

      requirement("dropWhile should work correctly", function () : void {
        Assert.equal(-3, new ArraySequence([1, 2, -3, -4]).dropWhile(positive).first); });
    }

    private static function positive(number : int) : Boolean
    { return number > 0; }
  }
}
