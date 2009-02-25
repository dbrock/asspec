package org.asspec.lang
{
  import flash.utils.describeType;

  import org.asspec.util.Reflection;

  public class RealNativeClass implements NativeClass
  {
    private var realClass : Class;

    public function RealNativeClass(realClass : Class)
    { this.realClass = realClass; }

    public function get name() : String
    { return Reflection.getLocalClassName(realClass); }

    public function getNewInstance() : Object
    { return new realClass; }

    public function forEachMethod(callback : Function) : void
    {
      for each (var method : UnboundMethod in methods)
        callback(method);
    }

    public function get methods() : Array
    {
      const result : Array = [];

      for each (var method : XML in describeType(realClass).factory.method)
        result.push(new RealUnboundMethod(method.@name, this));

      result.sort(compareMethods);

      return result;
    }

    private static function compareMethods
      (a : UnboundMethod, b : UnboundMethod) : int
    { return a.name < b.name ? -1 : +1; }

    public function get numMethods() : uint
    { return methods.length; }

    public function hasMethod(name : String) : Boolean
    { return getMethod(name) != null; }

    public function getMethod(name : String) : UnboundMethod
    {
      for each (var method : UnboundMethod in methods)
        if (method.name == name)
          return method;

      return null;
    }

    public static function forClass(realClass : Class) : NativeClass
    { return new RealNativeClass(realClass); }
  }
}
