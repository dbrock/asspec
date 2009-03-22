package org.asspec.basic
{
  import org.asspec.NamedTest;
  import org.asspec.TestListener;

  public class BasicTest implements NamedTest
  {
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
          listener.testPassed(this);
        }
      catch (error : Error)
        { listener.testFailed(this, error); }
    }

    protected function execute() : void
    {}
  }
}
