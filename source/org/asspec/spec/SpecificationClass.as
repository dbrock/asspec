package org.asspec.spec
{
  import org.asspec.lang.NativeClass;

  public class SpecificationClass implements SpecificationFactory
  {
    private var nativeClass : NativeClass;

    public function SpecificationClass(nativeClass : NativeClass)
    { this.nativeClass = nativeClass; }

    public function newSpecification() : Specification
    { return Specification(nativeClass.getNewInstance()); }
  }
}
