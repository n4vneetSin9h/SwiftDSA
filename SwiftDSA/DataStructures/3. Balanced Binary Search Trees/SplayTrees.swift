//
//  SplayTrees.swift
//  SwiftDSA
//
//  Created by Navneet Singh on 22/10/24.
//

class SplayNode<K: Comparable> {
    var key: K
    var left: SplayNode?
    var right: SplayNode?

    init(key: K) {
        self.key = key
    }
}

class SplayTree<K: Comparable> {
    private var root: SplayNode<K>?

    // Splay operation
    private func splay(_ node: SplayNode<K>?) {
        guard let node = node else { return }

        while let parent = findParent(of: node) {
            if parent.left === node {
                // Zig rotation
                rightRotate(parent)
            } else {
                // Zag rotation
                leftRotate(parent)
            }
        }
    }

    // Find the parent of a node
    private func findParent(of node: SplayNode<K>) -> SplayNode<K>? {
        return findParentHelper(root, node)
    }

    private func findParentHelper(_ current: SplayNode<K>?, _ node: SplayNode<K>) -> SplayNode<K>? {
        guard let current = current else { return nil }

        if current.left === node || current.right === node {
            return current
        }

        if node.key < current.key {
            return findParentHelper(current.left, node)
        } else {
            return findParentHelper(current.right, node)
        }
    }

    // Rotate right
    private func rightRotate(_ node: SplayNode<K>) {
        guard let leftChild = node.left else { return }
        node.left = leftChild.right
        leftChild.right = node

        if node === root {
            root = leftChild
        }
    }

    // Rotate left
    private func leftRotate(_ node: SplayNode<K>) {
        guard let rightChild = node.right else { return }
        node.right = rightChild.left
        rightChild.left = node

        if node === root {
            root = rightChild
        }
    }

    // Insert a new key
    func insert(key: K) {
        let newNode = SplayNode(key: key)
        root = insertHelper(root, newNode)
        splay(newNode)
    }

    private func insertHelper(_ current: SplayNode<K>?, _ newNode: SplayNode<K>) -> SplayNode<K>? {
        guard let current = current else { return newNode }

        if newNode.key < current.key {
            current.left = insertHelper(current.left, newNode)
        } else {
            current.right = insertHelper(current.right, newNode)
        }
        return current
    }

    // Find a key
    func find(key: K) -> SplayNode<K>? {
        guard let foundNode = findHelper(root, key) else { return nil }
        splay(foundNode)
        return foundNode
    }

    private func findHelper(_ current: SplayNode<K>?, _ key: K) -> SplayNode<K>? {
        guard let current = current else { return nil }

        if key == current.key {
            return current
        } else if key < current.key {
            return findHelper(current.left, key)
        } else {
            return findHelper(current.right, key)
        }
    }

    // In-Order Traversal
    func printInOrderTraversal() {
        inOrderTraversal(node: root)
    }

    private func inOrderTraversal(node: SplayNode<K>?) {
        guard let node = node else { return }
        inOrderTraversal(node: node.left)
        print(node.key) // Display key
        inOrderTraversal(node: node.right)
    }

    // Pre-Order Traversal
    func printPreOrderTraversal() {
        preOrderTraversal(node: root)
    }

    private func preOrderTraversal(node: SplayNode<K>?) {
        guard let node = node else { return }
        print(node.key) // Display key
        preOrderTraversal(node: node.left)
        preOrderTraversal(node: node.right)
    }

    // Post-Order Traversal
    func printPostOrderTraversal() {
        postOrderTraversal(node: root)
    }

    private func postOrderTraversal(node: SplayNode<K>?) {
        guard let node = node else { return }
        postOrderTraversal(node: node.left)
        postOrderTraversal(node: node.right)
        print(node.key) // Display key
    }
}
