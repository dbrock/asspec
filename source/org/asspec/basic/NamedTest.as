package org.asspec.basic
{
  public class NamedTest extends PristineTest
  {
    private var _name : String;

    public function NamedTest(name : String)
    { _name = name; }

    override public function get name() : String
    { return _name; }
  }
}
