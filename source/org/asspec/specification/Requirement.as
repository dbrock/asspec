package org.asspec.specification
{
  public class Requirement
  {
    private var _name : String;
    private var _implementation : Function;

    public function Requirement(name : String, implementation : Function)
    {
      _name = name;
      _implementation = implementation;
    }

    public function get name() : String
    { return _name; }

    public function get implementation() : Function
    { return _implementation; }

    public static function of
      (name : String, implementation : Function) : Requirement
    { return new Requirement(name, implementation); }
  }
}
