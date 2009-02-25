package org.asspec.basic
{
  import org.asspec.NamedTest;
  import org.asspec.util.UnimplementedMethodError;

  public class NamedManualTest extends ManualTest implements NamedTest
  {
    public function get name() : String
    { throw new UnimplementedMethodError; }
  }
}
