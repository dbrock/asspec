package org.asspec.util.mappings
{
  import org.asspec.util.foreach.Foreachable;

  public interface Mappable
  {
    function get empty() : Boolean;
    function get size() : uint;
    function has(key : Object) : Boolean;
    function get(key : Object) : *;
    function get keys() : Foreachable;
    function get values() : Foreachable;
    function get pairs() : Foreachable;
  }
}
