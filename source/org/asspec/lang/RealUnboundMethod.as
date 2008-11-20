package org.asspec.lang
{
  public class RealUnboundMethod implements UnboundMethod
  {
    private var _name : String;
    private var _owningClass : NativeClass;

    public function RealUnboundMethod(name : String, owningClass : NativeClass)
    {
      _name = name;
      _owningClass = owningClass;
    }

    public function get name() : String
    { return _name; }

    public function get owningClass() : NativeClass
    { return _owningClass; }

    public function invoke(target : Object) : Object
    {
      target[name]();
      return null;
    }
  }
}
