package org.asspec.specification
{
  import org.asspec.basic.Suite;

  public class SpecificationSuite extends Suite
  {
    private var provider : SpecificationProvider;

    public function SpecificationSuite(provider : SpecificationProvider)
    { this.provider = provider; }

    override protected function populate() : void
    { provider.getSpecificationCopy().accept(executor); }

    private function get executor() : SpecificationVisitor
    { return new SuiteDefinitionVisitor(this, provider); }
  }
}
