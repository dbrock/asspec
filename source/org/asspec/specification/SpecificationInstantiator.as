package org.asspec.specification
{
  import org.asspec.lang.NativeClass;

  public class SpecificationInstantiator implements SpecificationProvider
  {
    private var nativeClass : NativeClass;

    public function SpecificationInstantiator(nativeClass : NativeClass)
    { this.nativeClass = nativeClass; }

    public function getSpecificationCopy() : Specification
    { return Specification(nativeClass.getNewInstance()); }
  }
}
