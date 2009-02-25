package org.asspec.specification
{
  public interface Specification
  {
    function get name() : String;
    function accept(visitor : SpecificationVisitor) : void;
  }
}
