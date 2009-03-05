package org.asspec.util.mappings
{
  public interface Mappable
  {
    function has(key : Object) : Boolean;
    function get(key : Object) : *;
  }
}
