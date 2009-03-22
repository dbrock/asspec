package {
  import org.asspec.CompleteSuite;
  import org.asspec.ui.SimpleRunner;

  public class specification extends SimpleRunner
  {
    public function specification()
    { super(new CompleteSuite); }
  }
}
