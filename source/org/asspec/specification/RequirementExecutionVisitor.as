package org.asspec.specification
{
  public class RequirementExecutionVisitor implements SpecificationVisitor
  {
    private var requirementName : String;
    public var error : Error;

    public function RequirementExecutionVisitor(requirementName : String)
    { this.requirementName = requirementName; }

    private static function $$begin_asspec_test$$(implementation : Function) : void
    { implementation(); }

    public function visitRequirement(requirement : Requirement) : void
    {
      if (requirement.name == requirementName)
        try
          { $$begin_asspec_test$$(requirement.implementation); }
        catch (error : Error)
          { this.error = error; }
    }
  }
}
