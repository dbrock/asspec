package org.asspec.util.inspection
{
  import flash.utils.getQualifiedClassName;

  public class Inspector
  {
    private var object : Object;

    public static function inspect(object : Object) : String
    { return new Inspector(object).representation; }

    public function Inspector(object : Object)
    { this.object = object; }

    public function get representation() : String
    {
      if (object == null)
        return "null";
      else if (object is String)
        return new StringInspector(object as String).representation;
      else if (object is Array)
        return new ArrayInspector(object as Array).representation;
      else if (getQualifiedClassName(object) == "Object")
        return new ObjectInspector(object).representation;
      else
        return object.toString();
    }
  }
}
