package org.asspec.classic
{
  import org.asspec.specify;

  public function assertEqualsEither(actual : Object, expected : Array) : void
  { specify(actual).should.equal_either_element_of(expected); }
}
