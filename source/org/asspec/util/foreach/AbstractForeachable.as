package org.asspec.util.foreach
{
  import flash.utils.Proxy;
  import flash.utils.flash_proxy;

  import org.asspec.util.UnimplementedMethodError;

  use namespace foreach_support;

  public class AbstractForeachable extends Proxy implements Foreachable
  {
    foreach_support function get length() : uint
    { throw new UnimplementedMethodError; }

    foreach_support function getElementAt(index : int) : Object
    { throw new UnimplementedMethodError; }

    override flash_proxy function nextNameIndex(index : int) : int
    { return index == foreach_support::length ? 0 : index + 1; }

    override flash_proxy function nextValue(index : int) : *
    { return foreach_support::getElementAt(index - 1); }

    override flash_proxy function getProperty(name : *) : *
    { return foreach_support::getElementAt(parseInt(name)); }
  }
}
