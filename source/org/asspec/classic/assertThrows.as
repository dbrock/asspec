package org.asspec.classic
{
  import org.asspec.specify;

  public function assertThrows(thunk : Function) : void
  { specify(thunk).should.throw_error; }
}
