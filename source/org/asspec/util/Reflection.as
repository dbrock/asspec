package org.asspec.util
{
  import flash.utils.getQualifiedClassName;

  public class Reflection
  {
    public static function getLocalName(qualifiedName : String) : String
    { return qualifiedName.replace(/.*::/, ""); }

    public static function getLocalClassName(object : Object) : String
    { return getLocalName(getQualifiedClassName(object)); }
  }
}
