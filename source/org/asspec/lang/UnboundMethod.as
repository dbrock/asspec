package org.asspec.lang
{
  public interface UnboundMethod
  {
    function get name() : String;
    function get owningClass() : NativeClass;
    function invoke(target : Object) : Object;
  }
}
