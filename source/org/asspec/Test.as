package org.asspec
{
  public interface Test
  {
    function get name() : String;
    function run(listener : TestListener) : void;
  }
}
