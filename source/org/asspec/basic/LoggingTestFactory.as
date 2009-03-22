package org.asspec.basic
{
  import org.asspec.Test;

  internal class LoggingTestFactory implements TestFactory
  {
    public var log : String = "";

    public function getTestFromTestClass(class_ : Class) : Test
    {
      log += "test-class";

      return new BasicTest;
    }

    public function getTestFromSpecificationClass(class_ : Class) : Test
    {
      log += "specification-class";

      return new BasicTest;
    }

    public function getTestFromClassicTestClass(class_ : Class) : Test
    {
      log += "classic-test-class";

      return new BasicTest;
    }
  }
}
