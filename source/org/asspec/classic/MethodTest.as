package org.asspec.classic
{
  import org.asspec.basic.BasicTest;
  import org.asspec.lang.UnboundMethod;

  public class MethodTest extends BasicTest
  {
    private var method : UnboundMethod;

    public function MethodTest(method : UnboundMethod)
    { this.method = method; }

    override protected function execute() : void
    { $$begin_asspec_test$$(); }

    private function $$begin_asspec_test$$() : void
    { method.bind(method.owningClass.getNewInstance())(); }

    override public function get name() : String
    { return method.name + " (" + method.owningClass.name + ")"; }
  }
}
