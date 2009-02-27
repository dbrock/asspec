package org.asspec.story.narrative.scanning
{
  import org.asspec.equality.Equality;
  import org.asspec.util.curry;
  import org.asspec.util.sequences.Sequence;

  public class Paragraph
  {
    public var lines : Sequence;

    public function Paragraph(lines : Sequence)
    {
      lines.ensureType(Line);

      this.lines = lines;
    }

    public function get contextLines() : Sequence
    { return lines.filter(Line.isContextLine); }

    public function get stimulationLines() : Sequence
    { return lines.filter(Line.isStimulationLine); }

    public function get verificationLines() : Sequence
    { return lines.filter(Line.isVerificationLine); }

    public function linesBefore(line : Line) : Sequence
    { return lines.takeUntil(curry(Equality.equals, line)); }
  }
}
