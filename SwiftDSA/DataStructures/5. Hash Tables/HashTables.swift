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
    
    init(key: K, value: V) {
        self.key = key
        self.value = value
    }
}

class HashTable<K: Hashable, V> {
    private var entries = Array<HashEntry<K, V>?>(repeating: nil, count: HashTableConstants.initialSize)
    
    func put(_ key: K, _ value: V) {
        
    }
}

