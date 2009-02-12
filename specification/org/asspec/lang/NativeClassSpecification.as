package org.asspec.lang
{
  import org.asspec.Assert;
  import org.asspec.spec.Specification;

  public class NativeClassSpecification extends Specification
  {
    override protected function execute() : void
    {
      const emptyClass : NativeClass
        = RealNativeClass.forClass(Empty);

      requirement("an empty class should have zero methods", function () : void {
        Assert.equal(0, emptyClass.numMethods); });

      const abcdeClass : NativeClass
        = RealNativeClass.forClass(ABCDE);

      requirement("methods should be alphabetically ordered", function () : void {
        const methodNames : Array = [];

        for each (var method : UnboundMethod in abcdeClass.methods)
          methodNames.push(method.name);

        Assert.equal("a b c d e", methodNames.join(" "));
      });

      const counterClass : NativeClass
        = RealNativeClass.forClass(Counter);

      requirement("counter class should have one method", function () : void {
        Assert.equal(1, counterClass.numMethods); });
      requirement("counter class should have method »count«", function () : void {
        Assert.that(counterClass.hasMethod("count")); });
      requirement("unbound method should have owning class", function () : void {
        Assert.notNull(counterClass.getMethod("count").owningClass); });
      requirement("should instantiate correctly", function () : void {
        Assert.that(counterClass.getNewInstance() is Counter); });
      requirement("should invoke native method", function () : void {
        const counter : Counter = new Counter;

        counterClass.getMethod("count").invoke(counter);

        Assert.equal(1, counter.numInvocations);
      });
    }
  }
}

class Empty
{}

class ABCDE
{
  public function b() : void {}
  public function a() : void {}
  public function d() : void {}
  public function c() : void {}
  public function e() : void {}
}

class Counter
{
  public var numInvocations : uint = 0;

  public function count() : void
  { ++numInvocations; }
}
