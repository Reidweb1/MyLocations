/*
*
*   Not entirely sure if I got a solution but regardless
*   I feel much more confident with has tables after this
*   exercise
*
*/



import UIKit

class HashTable {
    var size: Int!
    var hashArray: [HashBucket]?
    var count = 0
    var newSize : Int?
    var newHashArray : [HashBucket]?
    
    init(size: Int) {
        self.size = size
        for i in 0..<size {
            var bucket = HashBucket()
            var hashArray = [HashBucket]()
            self.hashArray!.append(bucket)
        }
    }
    
    func hash(key: String) -> Int {
        var total = 0
        
        for character in key.unicodeScalars {
            var asc = Int(character.value)
            total += asc
        }
        
        return total % self.size
    }
    
    func setObject(object: AnyObject, forKey: String) {
        var index = self.hash(forKey)
        
        var bucket = HashBucket()
        bucket.key = forKey
        bucket.value = object
        bucket.next = self.hashArray![index]
        self.hashArray![index] = bucket
        self.count++
        if self.count >= self.size * 3/4 {
            self.doubleArraySize()
        }
    }
    
    func removeObjectForKey(key: String) {
        var index = self.hash(key)
        var previousBucket : HashBucket?
        var bucket : HashBucket? = self.hashArray![index]
        
        while bucket != nil {
            if bucket!.key == key {
                var nextBucket = bucket?.next
                self.hashArray![index] = bucket!.next!
                bucket = self.hashArray![index].next
            } else {
                previousBucket?.next = bucket?.next
            }
            self.count--
            return
        }
    }
    
    func doubleArraySize() {
        var oldSize = self.size
        self.size = self.size * 2
        for i in 0..<oldSize {
            self.newHashArray = [HashBucket]()
            self.hash(self.hashArray![i].key!)
            if var currentItem = self.hashArray![i].next {
                do {
                    var nextItem: HashBucket? = currentItem.next
                    self.hash(currentItem.key!)
                    if nextItem != nil {
                       currentItem = nextItem!
                    }
                } while currentItem.next != nil
            }
            self.newHashArray!.append(self.hashArray![i])
        }
        for i in oldSize..<self.size! {
            var bucket = HashBucket()
            self.newHashArray?.append(bucket)
        }
        self.newHashArray = self.hashArray
    }
}

class HashBucket {
    var next : HashBucket?
    var value : AnyObject?
    var key : String?
}
