//
//  Stacks.swift
//  SwiftDSA
//
//  Created by Navneet Singh on 19/10/24.
//

class Stack<T: Equatable & Comparable> {
    private var items: [T] = []
    
    var isEmpty: Bool { items.isEmpty }
    
    func push(_ item: T) { items.append(item) }
    
    func pop() -> T? { guard !isEmpty else { return nil }; return items.removeLast() }
    
    func peek() -> T? { items.last }
    
    func size() -> Int { items.count }
    
    func clear() { items = [] }
    
    func search(_ item: T) -> Int? {
        for i in 0..<items.count {
            let index = items.count - i - 1
            if items[index] == item {
                return i
            }
        }
        return nil
    }
    
    func swap(at idx1: Int? = nil, with idx2: Int? = nil) throws {
        let count = items.count
        guard count > 1 else { throw StackError.StackOnlyOneElementError }
        if idx1 == nil, idx2 == nil {
            let temp = items.last!
            items[count - 1] = items[count - 2]
            items[count - 2] = temp
        } else if idx1 != nil, idx2 == nil {
            if idx1! > count - 1 || idx1! < 0 { throw StackError.StackOutOfBoundError }
            if idx1! == count - 1 { return }
            let temp = items.last!
            items[count - 1] = items[idx1!]
            items[idx1!] = temp
        } else if idx1 == nil, idx2 != nil {
            if idx2! > count - 1 || idx2! < 0 { throw StackError.StackOutOfBoundError }
            if idx2! == count - 1 { return }
            let temp = items.last!
            items[count - 1] = items[idx2!]
            items[idx2!] = temp
        } else {
            if idx1! > count - 1 || idx2! > count - 1 || idx1! < 0 || idx2! < 0 { throw StackError.StackOutOfBoundError }
            if idx1! == count - 1 || idx2! == count - 1 { return }
            if idx1! == idx2! { return }
            let temp = items[idx1!]
            items[idx1!] = items[idx2!]
            items[idx2!] = temp
        }
    }
    
    func duplicate(from idx: Int? = nil) throws {
        if isEmpty { return }
        if idx == nil {
            items.append(items.last!)
            return
        }
        if idx! >= items.count || idx! < 0 { throw StackError.StackOutOfBoundError }
        items.append(items[idx!])
    }
    
    func reverse() {
        if items.count < 1 { return }
        try! subReverse(from: 0, to: items.count - 1)
    }
    
    private func subReverse(from idx1: Int, to idx2: Int) throws {
        if isEmpty { return }
        if idx1 > items.count - 1 || idx2 > items.count - 1 || idx1 < 0 || idx2 < 0 { throw StackError.StackOutOfBoundError }
        var i = idx1
        var j = idx2
        while i < j {
            let temp = items[j]
            items[j] = items[i]
            items[i] = temp
            i += 1
            j -= 1
        }
    }
    
    func rotateTopToBottom(_ direction: Bool = true) {
        if items.count < 1 { return }
        reverse()
        try! subReverse(from: direction ? 1:0, to: items.count - (direction ? 1:2))
    }
    
    func insertAtBottom(item: T) {
        items.append(item)
        rotateTopToBottom()
    }
    
    func removeAtBottom() -> T? {
        if isEmpty { return nil }
        return items.removeFirst()
    }
    
    func sort(inAscending order: Bool = true) {
        items.sort(by: order ? {$0 < $1}:{$0 > $1})
    }
    
    func printStack() {
        print(items)
    }
}

enum StackError: Error {
    case StackOutOfBoundError
    case StackOnlyOneElementError
}
