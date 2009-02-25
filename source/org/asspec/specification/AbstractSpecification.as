package org.asspec.specification
{
  import org.asspec.assertion.AssertionSubject;
  import org.asspec.util.Reflection;
  import org.asspec.util.UnimplementedMethodError;

  public class AbstractSpecification implements Specification
  {
    protected function execute() : void
    { throw new UnimplementedMethodError; }

    // ----------------------------------------------------

    private var visitor : SpecificationVisitor;

    public function get name() : String
    { return Reflection.getLocalClassName(this); }

    public function accept(visitor : SpecificationVisitor) : void
    {
      this.visitor = visitor;
      execute();
    }

    // ----------------------------------------------------

    protected function requirement
      (name : String, implementation : Function) : void
    { visitRequirement(name, implementation); }

    protected function it
      (name : String, implementation : Function) : void
    { visitRequirement(name, implementation); }

    private function visitRequirement
      (name : String, implementation : Function) : void
    { visitor.visitRequirement(new Requirement(name, implementation)); }

    // ----------------------------------------------------

    protected function $(subject : Object) : AssertionSubject
    { return AssertionSubject.of(subject); }
  }
}
