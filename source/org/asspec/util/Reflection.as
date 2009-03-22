package org.asspec.util
{
  import flash.utils.getQualifiedClassName;

  import org.asspec.util.inspection.Inspector;

  public class Reflection
  {
    public static function getLocalName(qualifiedName : String) : String
    { return qualifiedName.replace(/.*::/, ""); }

    public static function getLocalClassName(object : Object) : String
    { return getLocalName(getQualifiedClassName(object)); }

    public static function inspect(object : Object) : String
    { return Inspector.inspect(object); }
  }
}
