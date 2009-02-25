package org.asspec.classic
{
  import org.asspec.specify;

  public function assertNotSame(actual : Object, expected : Object) : void
  { specify(actual).should.not.be_the_same_object_as(expected); }
}
