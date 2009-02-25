package org.asspec.specification
{
  import org.asspec.lang.NativeClass;
  import org.asspec.lang.RealNativeClass;

  public class SpecificationSuiteFactory
  {
    public static function getSuiteForClass
      (class_ : Class) : SpecificationSuite
    {
      const nativeClass : NativeClass
        = RealNativeClass.forClass(class_);
      const provider : SpecificationProvider
        = new SpecificationInstantiator(nativeClass);

      return new SpecificationSuite(provider);
    }
  }
}
