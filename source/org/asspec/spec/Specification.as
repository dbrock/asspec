package org.asspec.spec
{
  import org.asspec.Test;
  import org.asspec.TestListener;
  import org.asspec.util.Reflection;

  public class Specification implements Test
  {
    private var executor : SpecificationExecutor;

    protected function execute() : void {}

    public function get name() : String
    { return Reflection.getLocalClassName(this); }

    public function run(listener : TestListener) : void
    { SpecificationRunner.run(this, listener); }

    public function executeWith(executor : SpecificationExecutor) : void
    {
      this.executor = executor;
      execute();
    }

    protected function requirement(name : String, implementation : Function) : void
    { executor.executeRequirement(name, implementation); }

    protected function it(name : String, implementation : Function) : void
    { requirement(name, implementation); }
  }
}
