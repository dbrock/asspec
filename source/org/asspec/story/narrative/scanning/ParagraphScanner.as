package org.asspec.story.narrative.scanning
{
  import org.asspec.util.Sequencable;
  import org.asspec.util.Text;
  import org.asspec.util.TypedArrayContainer;

  public class ParagraphScanner
  {
    public static function getParagraph(input : String) : Paragraph
    { return new ParagraphScanner(input).paragraph; }

    private const lines : TypedArrayContainer
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
