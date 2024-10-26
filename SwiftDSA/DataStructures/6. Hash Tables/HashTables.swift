//
//  HashTables.swift
//  SwiftDSA
//
//  Created by Navneet Singh on 22/10/24.
//


struct HashTableConstants {
    fileprivate static let initialSize = 256
}

class HashEntry<K: Hashable, V> {
    var key: K
    var value: V
    var next: HashEntry?
    
    init(_ key: K,_ value: V) {
        self.key = key
        self.value = value
    }
}

class HashTable<K: Hashable, V> {
    private var entries = Array<HashEntry<K, V>?>(repeating: nil, count: HashTableConstants.initialSize)
    
    private func getIndex(_ key: K) -> Int {
        // Get the key's hash code
        let hashCode = abs(key.hashValue)
        
        // Normalize it into an acceptable index
        let index = hashCode % HashTableConstants.initialSize
        print("\(key) \(hashCode) \(index)")
        
        // Forced collision for demonstration purposes
        if key as! String == "John Smith" || key as! String == "Sandra Dee" {
            return 152
        }
        
        return index
    }
    
    func put(_ key: K, _ value: V) {
        // Get the index
        let index = getIndex(key)
        
        // Create entry
        let entry = HashEntry(key, value)
        
        // If entry is not already there - store it
        if entries[index] == nil {
            entries[index] = entry
        }
        // else handle collision by appending to our linked list
        else {
            var collisions = entries[index]
            
            // Walk to the end
            while collisions?.next != nil {
                collisions = collisions?.next
            }
            
            // Add collision there
            collisions?.next = entry
        }
    }
    
    func get(_ key: K) -> V? {
        // Get the index
        let index = getIndex(key)
        
        // Get current list of entries for this index
        let possibleCollisions = entries[index]
        
        // Walk our linked list looking for a possible match on the key (that will be unique)
        var currentEntry = possibleCollisions
        while currentEntry != nil {
            if currentEntry?.key == key {
                return currentEntry?.value
            }
            currentEntry = currentEntry?.next
        }
        
        return nil
    }
    
    func prettyPrint() {
        for entry in entries {
            if entry == nil {
                continue
            }
            if entry?.next == nil {
                // nothing else there
                print("key: \(entry?.key ?? "Unkown Key" as! K) value: \(entry?.value ?? "Unknown Value" as! V)")
            } else {
                // collisions
                var currentEntry = entry
                while currentEntry?.next != nil {
                    print("💥 key: \(currentEntry?.key ?? "Unkown Key" as! K) value: \(currentEntry?.value ?? "Unknown Value" as! V)")
                    currentEntry = currentEntry?.next
                }
                print("💥 key: \(currentEntry?.key ?? "Unkown Key" as! K) value: \(currentEntry?.value ?? "Unknown Value" as! V)")
            }
        }
    }
    
    subscript(key: K) -> V? {
        get {
            get(key)
        }
        set(newValue) {
            guard let value = newValue else { return }
            put(key, value)
        }
    }
}


