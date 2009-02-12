package org.asspec.util.inspection
{
  public class StringInspector
  {
    private var string : String;
    private var content : String;

    public function StringInspector(string : String)
    {
      this.string = string;
      this.content = string;

      inspect();
    }

    public function get representation() : String
    { return '"' + content + '"'; }

    private function inspect() : void
    {
      replace(/\\/g, "\\\\");
      replace(/\n/g, "\\n");
      replace(/\r/g, "\\r");
      replace(/\t/g, "\\t");
      replace(new RegExp("\"", "g"), "\\\"");
    }

    private function replace(pattern : RegExp, replacement : String) : void
    { content = content.replace(pattern, replacement); }
  }
}
