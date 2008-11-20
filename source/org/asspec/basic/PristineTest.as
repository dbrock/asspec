package org.asspec.basic
{
  import org.asspec.TestListener;

  public class PristineTest extends AnonymousTest
  {
    protected var listener : TestListener;

    override public function run(listener : TestListener) : void
    {
      this.listener = listener;
      execute();
    }

    protected function execute() : void
    {}
  }
}
