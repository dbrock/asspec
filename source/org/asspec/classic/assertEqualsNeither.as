package org.asspec.classic
{
  import org.asspec.specify;

  public function assertEqualsNeither(actual : Object, expected : Array) : void
  { specify(actual).should.not.equal_either_element_of(expected); }
}
