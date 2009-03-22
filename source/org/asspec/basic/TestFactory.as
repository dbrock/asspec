package org.asspec.basic
{
  import org.asspec.Test;

  public interface TestFactory
  {
    function getTestFromTestClass(class_ : Class) : Test;
    function getTestFromSpecificationClass(class_ : Class) : Test;
    function getTestFromClassicTestClass(class_ : Class) : Test;
  }
}
