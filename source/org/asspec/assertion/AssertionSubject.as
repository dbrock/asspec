package org.asspec.assertion
{
  public class AssertionSubject
  {
    private var subject : Object;

    public function AssertionSubject(subject : Object)
    { this.subject = subject; }

    public function get should() : PositiveAssertionContext
    { return new PositiveAssertionContext(subject); }

    public static function of(subject : Object) : AssertionSubject
    { return new AssertionSubject(subject); }
  }
}
