package org.asspec.util.mappings
{
  public interface MappingContainer extends Mappable
  {
    function set(key : Object, value : Object) : void;
    function remove(key : Object) : void;
    function clear() : void;
  }
}
