package org.asspec.util.inspection
{
  public class ArrayInspector
  {
    private var array : Array;

    public function ArrayInspector(array : Array)
    { this.array = array; }

    public function get representation() : String
    { return "[" + content + "]"; }

    private function get content() : String
    {
      const parts : Array = [];

      for each (var element : Object in array)
        parts.push(Inspector.inspect(element));

      return parts.join(", ");
    }
  }
}
