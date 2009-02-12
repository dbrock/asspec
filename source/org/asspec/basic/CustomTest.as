package org.asspec.basic
{
  import org.asspec.basic.BasicTest;

  public class CustomTest extends BasicTest
  {
    private var implementation : Function;

    public function CustomTest
      (implementation : Function, name : String = null)
    {
      super(name);
      this.implementation = implementation;
    }

    override protected function execute() : void
    { implementation(); }
  }
}
