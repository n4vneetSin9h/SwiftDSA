//
//  RBTs.swift
//  SwiftDSA
//
//  Created by Navneet Singh on 22/10/24.
//

enum Color {
    case red
    case black
}

class RBNode<K: Comparable> {
    var key: K
    var color: Color
    var left: RBNode?
    var right: RBNode?
    var parent: RBNode?

    init(key: K, color: Color, parent: RBNode?) {
        self.key = key
        self.color = color
        self.parent = parent
    }
}

class RedBlackTree<K: Comparable> {
    private var root: RBNode<K>?

    // Rotate left
    private func leftRotate(_ x: RBNode<K>) {
        let y = x.right!
        x.right = y.left
        
        if let yLeft = y.left {
            yLeft.parent = x
        }
        
        y.parent = x.parent
        
        if x.parent == nil {
            root = y
        } else if x === x.parent?.left {
            x.parent?.left = y
        } else {
            x.parent?.right = y
        }
        
        y.left = x
        x.parent = y
    }

    // Rotate right
    private func rightRotate(_ y: RBNode<K>) {
        let x = y.left!
        y.left = x.right
        
        if let xRight = x.right {
            xRight.parent = y
        }
        
        x.parent = y.parent
        
        if y.parent == nil {
            root = x
        } else if y === y.parent?.left {
            y.parent?.left = x
        } else {
            y.parent?.right = x
        }
        
        x.right = y
        y.parent = x
    }

    // Fix the tree after insertion
    private func fixInsert(_ k: RBNode<K>) {
        var k = k
        
        while k.parent?.color == .red {
            if k.parent === k.parent?.parent?.left {
                let u = k.parent?.parent?.right // uncle
                
                if u?.color == .red { // Case 1
                    k.parent?.color = .black
                    u?.color = .black
                    k.parent?.parent?.color = .red
                    k = k.parent?.parent ?? k
                } else {
                    if k === k.parent?.right { // Case 2
                        k = k.parent ?? k
                        leftRotate(k)
                    }
                    // Case 3
                    k.parent?.color = .black
                    k.parent?.parent?.color = .red
                    rightRotate(k.parent?.parent ?? k)
                }
            } else {
                let u = k.parent?.parent?.left // uncle
                
                if u?.color == .red { // Case 1
                    k.parent?.color = .black
                    u?.color = .black
                    k.parent?.parent?.color = .red
                    k = k.parent?.parent ?? k
                } else {
                    if k === k.parent?.left { // Case 2
                        k = k.parent ?? k
                        rightRotate(k)
                    }
                    // Case 3
                    k.parent?.color = .black
                    k.parent?.parent?.color = .red
                    leftRotate(k.parent?.parent ?? k)
                }
            }
        }
        root?.color = .black
    }

    // Insert a new node
    func insert(key: K) {
        let newNode = RBNode(key: key, color: .red, parent: nil)
        var y: RBNode<K>? = nil
        var x: RBNode<K>? = root

        while x != nil {
            y = x
            if newNode.key < x!.key {
                x = x!.left
            } else {
                x = x!.right
            }
        }

        newNode.parent = y
        
        if y == nil {
            root = newNode // Tree was empty
        } else if newNode.key < y!.key {
            y!.left = newNode
        } else {
            y!.right = newNode
        }

        fixInsert(newNode)
    }

    // In-Order Traversal
    func printInOrderTraversal() {
        inOrderTraversal(node: root)
    }

    private func inOrderTraversal(node: RBNode<K>?) {
        guard let node = node else { return }
        inOrderTraversal(node: node.left)
        print("\(node.key) (\(node.color))") // Display key and color
        inOrderTraversal(node: node.right)
    }

    // Pre-Order Traversal
    func printPreOrderTraversal() {
        preOrderTraversal(node: root)
    }

    private func preOrderTraversal(node: RBNode<K>?) {
        guard let node = node else { return }
        print("\(node.key) (\(node.color))") // Display key and color
        preOrderTraversal(node: node.left)
        preOrderTraversal(node: node.right)
    }

    // Post-Order Traversal
    func printPostOrderTraversal() {
        postOrderTraversal(node: root)
    }

    private func postOrderTraversal(node: RBNode<K>?) {
        guard let node = node else { return }
        postOrderTraversal(node: node.left)
        postOrderTraversal(node: node.right)
        print("\(node.key) (\(node.color))") // Display key and color
    }
}
