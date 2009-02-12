package org.asspec.spec
{
  import org.asspec.basic.Suite;
  import org.asspec.lang.RealNativeClass;

  public class SpecificationSuite extends Suite
  {
    private var factory : SpecificationFactory;

    public function SpecificationSuite(factory : SpecificationFactory)
    { this.factory = factory; }

    override protected function populate() : void
    { factory.newSpecification().executeWith(executor); }

    private function get executor() : SpecificationExecutor
    { return new SuiteDefinitionExecutor(this, factory); }

    public static function forClass(class_ : Class) : SpecificationSuite
    {
      const specificationClass : SpecificationClass
        = new SpecificationClass(RealNativeClass.forClass(class_));

      return new SpecificationSuite(specificationClass);
    }
  }
}
