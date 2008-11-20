package org.asspec.spec
{
  public class RequirementExecutor implements SpecificationExecutor
  {
    private var requirementName : String;
    public var error : Error;

    public function RequirementExecutor(requirementName : String)
    { this.requirementName = requirementName; }

    private static function $$$beginTest$$$(implementation : Function) : void
    { implementation(); }

    public function executeRequirement
      (name : String, implementation : Function) : void
    {
      if (name == requirementName)
        try
          { $$$beginTest$$$(implementation); }
        catch (error : Error)
          { this.error = error; }
    }
  }
}
