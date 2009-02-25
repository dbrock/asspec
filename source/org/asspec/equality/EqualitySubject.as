package org.asspec.equality
{
  import org.asspec.util.EqualityComparable;
  import org.asspec.util.UnimplementedMethodError;

  public class EqualitySubject
  {
    public function equals(object : Object) : Boolean
    { throw new UnimplementedMethodError; }

    public function equalsEither(elements : Array) : Boolean
    {
      for each (var element : Object in elements)
        if (equals(element))
          return true;

      return false;
    }

    public static function of(subject : Object) : EqualitySubject
    {
      if (subject is EqualityComparable)
        return new ComparableSubject(EqualityComparable(subject));
      else if (subject is Array)
        return new ArraySubject(subject as Array);
      else
        return new DefaultSubject(subject);
    }
  }
}
