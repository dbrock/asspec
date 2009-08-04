package org.asspec.util.inspection
{
  import flash.utils.ByteArray;
  import flash.utils.getQualifiedClassName;

  public class Inspection
  {
    public static function inspect(object : Object) : String
    {
      if (object == null)
        return "null";
      else if (object is String)
        return new StringInspector(object as String).representation;
      else if (object is Array)
        return new ArrayInspector(object as Array).representation;
      else if (object is ByteArray)
        return new ByteArrayInspector(object as ByteArray).representation;
      else if (object is Date)
        return "Date[" + object.toString() + "]";
      else if (getQualifiedClassName(object) == "Object")
        return new ObjectInspector(object).representation;
      else
        return object.toString();
    }
  }
}
