package {
  import org.asspec.CompleteSpecificationSuite;
  import org.asspec.ui.SimpleRunner;

  public class specification extends SimpleRunner
  {
    public function specification()
    { super(new CompleteSpecificationSuite); }
  }
}
