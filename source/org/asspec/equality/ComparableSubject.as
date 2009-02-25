package org.asspec.equality
{
  import org.asspec.util.EqualityComparable;

  public class ComparableSubject extends EqualitySubject
  {
    private var subject : EqualityComparable;

    public function ComparableSubject(subject : EqualityComparable)
    { this.subject = subject; }

    override public function equals(object : Object) : Boolean
    {
      return object is EqualityComparable
        && subject.equals(EqualityComparable(object));
    }
  }
}
