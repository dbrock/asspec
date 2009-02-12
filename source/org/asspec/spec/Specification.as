package org.asspec.spec
{
  import org.asspec.util.Reflection;
  import org.asspec.util.UnimplementedMethodError;

  public class Specification
  {
    protected function execute() : void
    { throw new UnimplementedMethodError; }

    // ----------------------------------------------------

    private var executor : SpecificationExecutor;

    public function get name() : String
    { return Reflection.getLocalClassName(this); }

    public function executeWith(executor : SpecificationExecutor) : void
    {
      this.executor = executor;
      execute();
    }

    // ----------------------------------------------------

    protected function requirement
      (name : String, implementation : Function) : void
    { executor.executeRequirement(name, implementation); }

    protected function it(name : String, implementation : Function) : void
    { requirement(name, implementation); }
  }
}
