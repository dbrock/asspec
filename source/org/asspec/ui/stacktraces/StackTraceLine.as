package org.asspec.ui.stacktraces
{
  public class StackTraceLine
  {
    public var methodName : String;

    public function StackTraceLine(methodName : String)
    { this.methodName = methodName; }

    public function toString() : String
    { return "    at " + methodName; }

    public static function parse(input : String) : StackTraceLine
    {
      const match : Array = input.match(/^\s+at (.*?)(\[(.*):(\d+)\])?$/);
      const methodName : String = match[1];

      if (match[3] == null)
        return new StackTraceLine(methodName);
      else
        {
          const fileName : String = match[3].replace(/.*[\/\\](.*)$/, "$1");
          const lineNumber : uint = parseInt(match[4]);

          return new FileStackTraceLine(methodName, fileName, lineNumber);
        }
    }
  }
}
