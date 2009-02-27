package org.asspec.util.inspection
{
  public class ObjectInspector
  {
    private var object : Object;

    public function ObjectInspector(object : Object)
    { this.object = object; }

    public function get representation() : String
    {
      if (empty)
        return "{}";
      else
        return "{ " + content + " }";
    }

    private function get empty() : Boolean
    {
      for (var name : String in object)
        return false;

      return true;
    }

    private function get content() : String
    {
      const parts : Array = [];

      for (var name : String in object)
        parts.push(getPropertyLiteral(name, object[name]));

      return parts.join(", ");
    }

    private function getPropertyLiteral(name : String, value : Object) : String
    { return getNameLiteral(name) + ": " + Inspection.inspect(value); }

    private function getNameLiteral(string : String) : String
    {
      if (string.match(/^[a-zA-Z0-9$_]+$/))
        return string;
      else
        return Inspection.inspect(string);
    }
  }
}
