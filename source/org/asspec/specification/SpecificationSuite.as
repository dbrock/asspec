package org.asspec.specification
{
  import org.asspec.basic.AbstractSuite;

  public class SpecificationSuite extends AbstractSuite
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
