package org.asspec.lang
{
  public interface NativeClass
  {
    function get name() : String;
    function getNewInstance() : Object;
    function get methods() : Array;
    function forEachMethod(callback : Function) : void
    function get numMethods() : uint;
    function hasMethod(name : String) : Boolean;
    function getMethod(name : String) : UnboundMethod;
  }
}
