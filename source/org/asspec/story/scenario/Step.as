package org.asspec.story.scenario
{
  public class Step
  {
    private var _name : String;

    public function Step(name : String)
    { _name = name; }

    public function get name() : String
    { return _name; }

    public function toString() : String
    { return name; }
  }
}
