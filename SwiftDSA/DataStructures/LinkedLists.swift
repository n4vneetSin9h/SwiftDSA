//
//  LinkedLists.swift
//  SwiftDSA
//
//  Created by Navneet Singh on 20/10/24.
//

class SNode<T: Equatable & Comparable> {
    var value: T! = nil
    var next: SNode<T>? = nil
    
    init(value: T) {
        self.value = value
    }
    
    static func ==(lhs: SNode<T>, rhs: SNode<T>) -> Bool {
        return lhs.value == rhs.value
    }
}

class SLList<T: Equatable & Comparable> {
    var head: SNode<T>? = nil
    
    var isEmpty: Bool { head == nil }
    
    func insertAtHead(item: SNode<T>) {
        if head == nil {
            head = item
            return
        }
        
        item.next = head
        head = item
    }
    
    func insertAtTail(item: SNode<T>) {
        if head == nil {
            head = item
            return
        }
        
        var node = head
        while node!.next != nil {
            node = node!.next!
        }
        node!.next = item
    }
    
    func removeHead() -> SNode<T>? {
        if head == nil { return nil }
        let node = head
        head = head!.next
        return node
    }
    
    func removeTail() -> SNode<T>? {
        if head == nil { return nil }
        if head!.next == nil {
            let node = head!
            head = nil
            return node
        }
        var node = head
        var newTail: SNode<T>?
        while node!.next != nil {
            newTail = node
            node = node!.next
        }
        newTail!.next = nil
        return node
    }
    
    func size() -> Int {
        var count = 0
        var node = head
        while node != nil {
            count += 1
            node = node!.next
        }
        return count
    }
    
    func contains(item: SNode<T>) -> Bool {
        var node = head
        while node != nil {
            if node! == item {
                return true
            }
            node = node!.next
        }
        return false
    }
}
