package org.asspec.specification
{
  public interface SpecificationVisitor
  {
    function visitRequirement(requirement : Requirement) : void;
    function visitContext(context : Context) : void;
  }
}
