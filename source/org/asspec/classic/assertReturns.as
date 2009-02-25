package org.asspec.classic
{
  import org.asspec.specify;

  public function assertReturns(thunk : Function) : void
  { specify(thunk).should.return_normally; }
}
