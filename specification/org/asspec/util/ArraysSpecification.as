package org.asspec.util
{
  import org.asspec.Assert;
  import org.asspec.spec.Specification;

  public class ArraysSpecification extends Specification
  {
    override protected function execute() : void
    {
      requirement("wrapping an array should do nothing", function () : void {
        Assert.equal(123, Arrays.wrap([123])[0]); });
      requirement("wrapping something should produce an array", function () : void {
        Assert.that(Arrays.wrap(123) is Array); });
      requirement("wrapping something should produce a singleton array", function () : void {
        Assert.equal(1, Arrays.wrap(123).length); });
      requirement("wrapping something should produce an array containing it", function () : void {
        Assert.equal(123, Arrays.wrap(123)[0]); });
    }
  }
}
