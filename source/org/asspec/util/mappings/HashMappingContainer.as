package org.asspec.util.mappings
{
  import flash.utils.Dictionary;
  import flash.utils.Proxy;
  import flash.utils.flash_proxy;
  
  import org.asspec.util.foreach.Foreachable;
  import org.asspec.util.sequences.ArraySequenceContainer;
  import org.asspec.util.sequences.Sequencable;
  import org.asspec.util.sequences.SequenceContainer;

  public class HashMappingContainer extends Proxy
    implements MappingContainer
  {
    internal var bucketContainer : Dictionary = new Dictionary;
    
    public function get empty() : Boolean
    {
      for (var hash : String in bucketContainer)
        return false;
      
      return true;
    }
    
    public function get size() : uint
    {
      var result : uint = 0;
      
      for (var hash : String in bucketContainer)
        result += getBucket(hash).size;
      
      return result;
    }
    
    public function has(key : Object) : Boolean
    {
      if (hasBucketFor(key))
        return getBucketFor(key).has(key);
      else
        return false;
    }
    
    private function getHash(object : Object) : String
    { return Hashable(object).hash; }
    
    private function hasBucketFor(key : Object) : Boolean
    { return hasBucket(getHash(key)); }
    
    private function getBucketFor(key : Object) : MappingContainer
    { return getBucket(getHash(key)); }
    
    private function hasBucket(hash : String) : Boolean
    { return hash in bucketContainer; }
    
    private function getBucket(hash : String) : MappingContainer
    { return bucketContainer[hash]; }

    private function createBucket(hash : String) : MappingContainer
    {
      const bucket : MappingContainer = new ArrayMappingContainer;
      
      bucketContainer[hash] = bucket;
      
      return bucket;
    }
    
    private function getOrCreateBucket(hash : String) : MappingContainer
    {
      if (hasBucket(hash))
        return getBucket(hash);
      else
        return createBucket(hash);
    }
      
    private function removeBucket(hash : String) : void
    { delete bucketContainer[hash]; }

    public function get(key : Object) : *
    { return getBucketFor(key).get(key); }

    public function set(key : Object, value : Object) : void
    { return getOrCreateBucket(getHash(key)).set(key, value); }

    public function remove(key : Object) : void
    {
      const hash : String = getHash(key);
      const bucket : MappingContainer = getBucket(hash);
      
      bucket.remove(key);
      
      if (bucket.empty)
        removeBucket(hash);
    }
    
    public function clear() : void
    { bucketContainer = new Dictionary; }

    public function get keys() : Foreachable
    {
      return mapPairs(function (pair : Pair) : Object
        { return pair.key; });
    }
    
    public function get values() : Foreachable
    {
      return mapPairs(function (pair : Pair) : Object
        { return pair.value; });
    }
    
    public function get pairs() : Foreachable
    {
      return mapPairs(function (pair : Pair) : Object
        { return pair; });
    }
    
    private function mapPairs(mapper : Function) : Sequencable
    {
      const result : SequenceContainer = new ArraySequenceContainer;
      
      forEachPair(function (pair : Pair) : void
        { result.add(mapper(pair)); });
        
      return result;
    }
    
    private function forEachPair(callback : Function) : void
    {
      for (var hash : String in bucketContainer)
        for each (var pair : Pair in getBucket(hash).pairs)
          callback(pair);
    }

    override flash_proxy function nextNameIndex(index : int) : int
    { throw new Error("Please use .keys, .values, or .pairs to iterate."); }
  }
}
