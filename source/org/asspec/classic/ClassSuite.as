package org.asspec.classic
{
  import org.asspec.basic.AbstractSuite;
  import org.asspec.lang.NativeClass;
  import org.asspec.lang.RealNativeClass;
  import org.asspec.lang.UnboundMethod;

  public class ClassSuite extends AbstractSuite
  {
    private var suiteClass : NativeClass;

    public function ClassSuite(suiteClass : NativeClass)
    { this.suiteClass = suiteClass; }

    public static function forClass(realClass : Class) : ClassSuite
    { return new ClassSuite(RealNativeClass.forClass(realClass)); }

    override protected function populate() : void
    { suiteClass.forEachMethod(addTestForMethod); }

    private function addTestForMethod(method : UnboundMethod) : void
    { addTest(new MethodTest(method)); }
  }
}
