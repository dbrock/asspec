package org.asspec
{
  import org.asspec.util.inspection.Inspection;

  public class AssertionError extends Error
  {
    protected function inspect(object : Object) : String
    { return "»" + Inspection.inspect(object) + "«"; }

    public function AssertionError(message : String = null)
    { super(message); }
  }
}
