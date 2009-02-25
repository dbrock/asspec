package org.asspec.equality
{
  public function equal(a : Object, b : Object) : Boolean
  { return EqualitySubject.of(a).equals(b); }
}
