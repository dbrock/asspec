package org.asspec.specification
{
  import org.asspec.AssertionError;
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

    protected function pending(description : String = null) : void
    {
      if (description == null)
        throw new AssertionError("Pending");
      else
        throw new AssertionError("Pending: " + description);
    }

    protected function requirement
      (name : String, implementation : Function = null) : void
    {
      const actualImplementation : Function
        = implementation == null ? pending : implementation;

      visitRequirement(name, actualImplementation);
    }

    protected function it
      (name : String, implementation : Function = null) : void
    {
      const actualImplementation : Function
        = implementation == null ? pending : implementation;

      visitRequirement(name, actualImplementation);
    }

    protected function describe
      (name : String, implementation : Function) : void
    { visitContext(name, implementation); }

    private function visitRequirement
      (name : String, implementation : Function) : void
    { visitor.visitRequirement(Requirement.of(name, implementation)); }

    private function visitContext
      (name : String, implementation : Function) : void
    { visitor.visitContext(Context.of(name, implementation)); }

    protected function specify(subject : Object) : AssertionSubject
    { return AssertionSubject.of(subject); }

    protected function fail(message : String = null) : void
    { throw new AssertionError(message); }
  }
}
