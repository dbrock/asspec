package org.asspec
{
  import org.asspec.ui.SimpleRunner;

  public class metasuite extends SimpleRunner
  {
    public function metasuite()
    { super(new CompleteMetasuite); }
  }
}
