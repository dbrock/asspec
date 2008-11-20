package org.asspec.spec
{
  import org.asspec.basic.BasicTest;

  public class Requirement extends BasicTest
  {
    private var requirementName : String;
    private var specification : Specification;
    private var executor : RequirementExecutor;

    public function Requirement(name : String, specification : Specification)
    {
      super(name + " (" + specification.name + ")");

      this.requirementName = name;
      this.specification = specification;
      this.executor = new RequirementExecutor(requirementName);
    }

    override protected function execute() : void
    {
      specification.executeWith(executor);

      if (executor.error != null)
        throw executor.error;
    }
  }
}
