package org.asspec.simple
{
  import org.asspec.basic.BasicTest;
  import org.asspec.lang.UnboundMethod;

  public class MethodTest extends BasicTest
  {
    private var method : UnboundMethod;

    public function MethodTest(method : UnboundMethod)
    { this.method = method; }

    override protected function execute() : void
    { $$$beginTest$$$(); }

    private function $$$beginTest$$$() : void
    { method.bind(method.owningClass.getNewInstance())(); }

    override public function get name() : String
    { return method.name; }
  }
}
