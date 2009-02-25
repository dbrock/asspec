package org.asspec.specification
{
  import org.asspec.basic.BasicTest;

  public class RequirementTest extends BasicTest
  {
    private var requirementName : String;
    private var specification : Specification;

    public function RequirementTest
      (name : String, specification : Specification)
    {
      super(name + " (" + specification.name + ")");

      this.requirementName = name;
      this.specification = specification;
    }

    override protected function execute() : void
    {
      const executor : RequirementExecutionVisitor
        = new RequirementExecutionVisitor(requirementName);

      specification.accept(executor);

      if (executor.error != null)
        throw executor.error;
    }
  }
}
