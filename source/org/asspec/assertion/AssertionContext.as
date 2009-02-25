package org.asspec.assertion
{
  public interface AssertionContext
  {
    function get not() : AssertionContext;

    function get hold() : Object;

    function be_the_same_object_as(expected : Object) : void;

    function equal(expected : Object) : void;
    function equal_either_of(... expected : Array) : void;
    function equal_either_element_of(expected : Array) : void;

    function look_like(expected : String) : void;

    function get return_normally() : Object;
    function get throw_error() : Object;
  }
}
