package org.asspec.lang
{
  import org.asspec.classic.assertNotNull;
  import org.asspec.classic.assertTrue;
  import org.asspec.specification.AbstractSpecification;
  import org.asspec.specify;

  public class NativeClassMetaspecification extends AbstractSpecification
  {
    override protected function execute() : void
    {
      const emptyClass : NativeClass
        = RealNativeClass.forClass(Empty);

      requirement("an empty class should have zero methods", function () : void {
        specify(emptyClass.numMethods).should.equal(0); });

      const abcdeClass : NativeClass
        = RealNativeClass.forClass(ABCDE);

      requirement("methods should be alphabetically ordered", function () : void {
        const methodNames : Array = [];

        for each (var method : UnboundMethod in abcdeClass.methods)
          methodNames.push(method.name);

        specify(methodNames.join(" ")).should.equal("a b c d e");
      });

      const counterClass : NativeClass
        = RealNativeClass.forClass(Counter);

      requirement("counter class should have one method", function () : void {
        specify(counterClass.numMethods).should.equal(1); });
      requirement("counter class should have method »count«", function () : void {
        assertTrue(counterClass.hasMethod("count")); });
      requirement("unbound method should have owning class", function () : void {
        assertNotNull(counterClass.getMethod("count").owningClass); });
      requirement("should instantiate correctly", function () : void {
        assertTrue(counterClass.getNewInstance() is Counter); });
      requirement("should invoke native method", function () : void {
        const counter : Counter = new Counter;

        counterClass.getMethod("count").invoke(counter);

        specify(counter.numInvocations).should.equal(1);
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
