package org.asspec.basic
{
  import org.asspec.Test;
  import org.asspec.TestListener;

  public class AnonymousTest implements Test
  {
    public function get name() : String
    { return null; }

    public function run(listener : TestListener) : void
    {}
  }
}
