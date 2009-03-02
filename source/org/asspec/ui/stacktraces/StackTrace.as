package org.asspec.ui.stacktraces
{
  import org.asspec.util.Text;
  import org.asspec.util.sequences.Sequence;

  public class StackTrace
  {
    private var errorMessage : String;
    private var lines : Sequence;

    public function StackTrace(errorMessage : String, lines : Sequence)
    {
      lines.ensureType(StackTraceLine);

      this.errorMessage = errorMessage;
      this.lines = lines;
    }

    public function cutoffBefore(predicate : Function) : StackTrace
    { return new StackTrace(errorMessage, lines.takeUntil(predicate)); }

    public function toString() : String
    { return errorMessage + "\n" + lines.join("\n"); }

    public static function fromError(error : Error) : StackTrace
    {
      const rawLines : Sequence = Text.of(error.getStackTrace()).lines;

      const errorMessage : String = rawLines.first;
      const lines : Sequence = rawLines.rest.map(StackTraceLine.parse);

      return new StackTrace(errorMessage, lines);
    }
  }
}
