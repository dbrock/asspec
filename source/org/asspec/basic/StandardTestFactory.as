package org.asspec.basic
{
  import org.asspec.Test;
  import org.asspec.classic.ClassSuite;
  import org.asspec.specification.SpecificationSuiteFactory;

  internal class StandardTestFactory implements TestFactory
  {
    public function getTestFromTestClass(class_ : Class) : Test
    { return new class_; }

    public function getTestFromSpecificationClass(class_ : Class) : Test
    { return SpecificationSuiteFactory.getSuiteForClass(class_); }

    public function getTestFromClassicTestClass(class_ : Class) : Test
    { return ClassSuite.forClass(class_); }
  }
}
