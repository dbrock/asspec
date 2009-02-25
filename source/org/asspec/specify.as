package org.asspec
{
  import org.asspec.assertion.AssertionSubject;

  public function specify(subject : Object) : AssertionSubject
  { return AssertionSubject.of(subject); }
}
