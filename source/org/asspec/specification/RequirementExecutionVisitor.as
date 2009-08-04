package org.asspec.specification
{
  import org.asspec.util.sequences.Sequence;

  public class RequirementExecutionVisitor implements SpecificationVisitor
  {
    private var contextNames : Sequence;
    private var requirementName : String;

    private var currentContextLevel : uint = 0;

    public var error : Error;

    public function RequirementExecutionVisitor
      (contextNames : Sequence, requirementName : String)
    {
      this.contextNames = contextNames;
      this.requirementName = requirementName;
    }

    private static function $$begin_asspec_test$$
      (implementation : Function) : void
    { implementation(); }

    public function visitRequirement(requirement : Requirement) : void
    {
      if (requirement.name == requirementName)
        try
          { $$begin_asspec_test$$(requirement.implementation); }
        catch (error : Error)
          { this.error = error; }
    }

    public function visitContext(context : Context) : void
    {
      if (shouldEnterContext(context))
        enterContext(context);
    }

    private function enterContext(context : Context) : void
    {
      ++currentContextLevel;
      (context.implementation)();
    }

    public function visitTailContext(name : String) : void
    { ++currentContextLevel; }

    private function shouldEnterContext(context : Context) : Boolean
    { return needMoreContext && context.name == nextContextName; }

    private function get needMoreContext() : Boolean
    { return currentContextLevel < contextNames.length; }

    private function get nextContextName() : String
    { return contextNames.get(currentContextLevel); }
  }
}
