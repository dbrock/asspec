package org.asspec.equality
{
  public class DefaultSubject extends EqualitySubject
  {
    private var subject : Object;

    public function DefaultSubject(subject : Object)
    { this.subject = subject; }

    override public function equals(object : Object) : Boolean
    { return subject === object; }
  }
}
