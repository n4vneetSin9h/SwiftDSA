//
//  Queues.swift
//  SwiftDSA
//
//  Created by Navneet Singh on 20/10/24.
//

class Queue<T: Equatable & Comparable> {
    private var items: [T] = []
    
    var isEmpty: Bool { items.isEmpty }
    
    func enqueue(item: T) { items.append(item) }
    
    func dequeue() -> T? { items.removeFirst() }
    
    func peek() -> T? { items.first }
    
    func size() -> Int { items.count }
    
    func clear() { items = [] }
    
    func contains(item: T) -> Bool {
        for i in items {
            if item == i {
                return true
            }
        }
        return false
    }
    
    func search(item: T) -> Int? {
        for (i, v) in items.enumerated() {
            if item == v {
                return i
            }
        }
        return nil
    }
    
}
