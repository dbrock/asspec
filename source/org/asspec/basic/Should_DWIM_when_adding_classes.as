package org.asspec.basic
{
  internal class Should_DWIM_when_adding_classes extends ManualTest
  {
    private const factory : LoggingTestFactory = new LoggingTestFactory;
    private const suite : AbstractSuite = new AbstractSuite;

    override protected function execute() : void
    {
      suite.factory = factory;

      testCase(ExampleTest, "test-class");
      testCase(ExampleSpecification, "specification-class");
      testCase(ExampleClassicTest, "classic-test-class");
    }

    private function testCase(class_ : Class, expectedType : String) : void
    {
      factory.log = "";

      suite.add(class_);

      if (factory.log == expectedType)
        listener.testPassed(this);
      else
        {
          const message : String
            = "expected " + expectedType + " but was " + factory.log;

          listener.testFailed(this, new Error(message));
        }
    }
  }
}

import org.asspec.basic.BasicTest;
import org.asspec.specification.AbstractSpecification;

class ExampleTest extends BasicTest
{}

class ExampleSpecification extends AbstractSpecification
{}

class ExampleClassicTest
{}
