package org.asspec.simple
{
  import org.asspec.Test;
  import org.asspec.basic.Suite;
  import org.asspec.lang.NativeClass;
  import org.asspec.lang.RealNativeClass;
  import org.asspec.lang.UnboundMethod;

  public class ClassSuite extends Suite
  {
    private var suiteClass : NativeClass;

    public function ClassSuite(suiteClass : NativeClass)
    { this.suiteClass = suiteClass; }

    public static function forClass(realClass : Class) : ClassSuite
    { return new ClassSuite(RealNativeClass.forClass(realClass)); }

    override protected function populate() : void
    { suiteClass.forEachMethod(addTest); }

    private function addTest(method : UnboundMethod) : void
    { add(new MethodTest(method)); }
  }
}
