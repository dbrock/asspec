package org.asspec.classic
{
  import org.asspec.specify;

  public function assertSame(actual : Object, expected : Object) : void
  { specify(actual).should.be_the_same_object_as(expected); }
}
