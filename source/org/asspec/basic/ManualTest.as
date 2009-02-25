package org.asspec.basic
{
  import org.asspec.Test;
  import org.asspec.TestListener;

  public class ManualTest implements Test
  {
    protected var listener : TestListener;

    public function run(listener : TestListener) : void
    {
      this.listener = listener;
      execute();
    }

    protected function execute() : void
    {}
  }
}
