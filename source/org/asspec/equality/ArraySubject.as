package org.asspec.equality
{
  public class ArraySubject extends EqualitySubject
  {
    private var subject : Array;

    public function ArraySubject(subject : Array)
    { this.subject = subject; }

    override public function equals(object : Object) : Boolean
    { return object is Array && arraysEqual(subject, object as Array); }

    private static function arraysEqual(a : Array, b : Array) : Boolean
    { return a.length == b.length && arrayContentsEqual(a, b); }

    private static function arrayContentsEqual(a : Array, b : Array) : Boolean
    {
      for (var i : uint = 0; i < a.length; ++i)
        if (!EqualitySubject.of(a[i]).equals(b[i]))
          return false;

      return true;
    }
  }
}
