package org.asspec.specification
{
  import org.asspec.basic.BasicTest;
  import org.asspec.util.sequences.Sequence;

  public class RequirementTest extends BasicTest
  {
    private var contextNames : Sequence;
    private var requirementName : String;
    private var specification : Specification;

    public function RequirementTest
      (contextNames : Sequence,
       requirementName : String,
       specification : Specification)
    {
      super(contextNames.snoc(requirementName).join(" ")
            + " (" + specification.name + ")");

      this.contextNames = contextNames;
      this.requirementName = requirementName;
      this.specification = specification;
    }

    override protected function execute() : void
    {
      const executor : RequirementExecutionVisitor
        = new RequirementExecutionVisitor(contextNames, requirementName);

      specification.accept(executor);

      if (executor.error != null)
        throw executor.error;
    }
  }
}
