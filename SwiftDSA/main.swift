//
//  main.swift
//  SwiftDSA
//
//  Created by Navneet Singh on 19/10/24.
//

import Foundation


let stack = Stack<Int>()

stack.push(2)
stack.push(3)
stack.push(9)
stack.push(5)
stack.push(6)
_ = stack.pop()
stack.push(4)
stack.printStack()
print(stack.peek()!)
try stack.swap()
stack.printStack()
try stack.swap(at: 3, with: 1)
stack.printStack()
try stack.swap(at: 0)
stack.printStack()
do {
    try stack.swap(with: 4)
} catch {
    print("Index out of range")
}
stack.printStack()
stack.rotateTopToBottom(false)
stack.printStack()
stack.insertAtBottom(item: 9)
stack.printStack()
stack.sort()
stack.printStack()
