package org.asspec.story.narrative.scanning
{
  import org.asspec.util.Text;
  import org.asspec.util.sequences.Sequencable;
  import org.asspec.util.sequences.TypedArrayContainer;
  import org.asspec.util.sequences.TypedSequenceContainer;

  public class ParagraphScanner
  {
    public static function getParagraph(input : String) : Paragraph
    { return new ParagraphScanner(input).paragraph; }

    private const lines : TypedSequenceContainer
      = new TypedArrayContainer(Line);

    public function ParagraphScanner(input : String)
    { getParagraph(Text.of(input).lines); }

    public function get paragraph() : Paragraph
    { return new Paragraph(lines.sequence); }

    private function getParagraph(rawLines : Sequencable) : void
    { rawLines.forEach(parseLine); }

    private function parseLine(input : String) : void
    { lines.add(new LineScanner(input).line); }

    private function get previousLine() : Line
    { return lines.last; }
  }
}
