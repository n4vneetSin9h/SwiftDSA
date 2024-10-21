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
    
    func search(item: SNode<T>) -> Int? {
        var index = 0
        var node = head
        while node != nil {
            if node! == item {
                return index
            }
            node = node!.next
            index += 1
        }
        return nil
    }
    
    func insert(at index: Int, item: SNode<T>) {
        if index < 0 || index > size() {
            return
        }
        
        // Inserting at the head
        if index == 0 {
            item.next = head
            head = item
            return
        }
        
        // Traverse the list to find the correct spot
        var idx = 0
        var node = head
        while node != nil {
            if index == idx + 1 {
                item.next = node!.next
                node!.next = item
                return
            }
            node = node!.next
            idx += 1
        }
    }
    
    func delete(at index: Int) -> SNode<T>? {
        if head == nil || index < 0 || index >= size() {
            return nil
        }
        
        if index == 0 {
            let node = head
            head = head?.next
            return node
        }
        
        var idx = 0
        var node = head
        var prev: SNode<T>? = nil
        while node != nil {
            if index == idx {
                prev?.next = node?.next
                return node
            }
            prev = node
            node = node?.next
            idx += 1
        }
        
        return nil
    }
    
    func reverse() {
        var prev: SNode<T>? = nil
        var current = head
        var next: SNode<T>? = nil
        
        while current != nil {
            // Store the next node
            next = current?.next
            
            // Reverse the current node's pointer
            current?.next = prev
            
            // Move prev and current one step forward
            prev = current
            current = next
        }
        
        // Update head to be the last processed node (prev)
        head = prev
    }
    
    func get(index: Int) -> SNode<T>? {
        var idx = 0
        var node = head
        while node != nil {
            if idx == index {
                return node
            }
            node = node?.next
            idx += 1
        }
        
        return nil
    }
    
}
