package org.asspec.basic
{
  import org.asspec.NamedTest;
  import org.asspec.TestListener;
  import org.asspec.util.UnimplementedMethodError;

  public class BasicTest implements NamedTest
  {
    protected function execute() : void
    { throw new UnimplementedMethodError; }

    private var _name : String;

    public function BasicTest(name : String = null)
    { _name = name; }

    public function get name() : String
    { return _name; }

    public function toString() : String
    { return name; }

    public function run(listener : TestListener) : void
    {
      try
        {
          execute();
          listener.handleTestPassed(this);
        }
      catch (error : Error)
        { listener.handleTestFailed(this, error); }
    }
  }
}
