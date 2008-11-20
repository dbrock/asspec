package org.asspec.spec
{
  import org.asspec.TestListener;
  import org.asspec.basic.Suite;

  public class SpecificationRunner
  {
    private var specification : Specification;
    private var listener : TestListener;

    private const suite : Suite = new Suite;

    public static function run
      (specification : Specification, listener : TestListener) : void
    { new SpecificationRunner(specification, listener).run(); }

    public function SpecificationRunner
      (specification : Specification, listener : TestListener)
    {
      this.specification = specification;
      this.listener = listener;
    }

    public function run() : void
    {
      defineSuite();
      runSuite();
    }

    private function defineSuite() : void
    { specification.executeWith(executor); }

    private function get executor() : SpecificationExecutor
    { return new SuiteDefinitionExecutor(suite, specification); }

    private function runSuite() : void
    { suite.run(listener); }
  }
}
