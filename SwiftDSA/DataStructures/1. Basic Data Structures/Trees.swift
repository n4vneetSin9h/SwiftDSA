//
//  Trees.swift
//  SwiftDSA
//
//  Created by Navneet Singh on 22/10/24.
//

class SimpleTree<K> {
    var value: K? = nil
    var children: [SimpleTree<K>] = []
    weak var parent: SimpleTree<K>?
    
    init(value: K? = nil, children: [SimpleTree<K>] = []) {
        self.value = value
        self.children = children
        self.children.forEach { $0.parent = self }
    }
    
    func add(_ child: SimpleTree<K>) {
        children.append(child)
    }
    
    // Traversal method: Depth-First Search
    func depthFirstTraversal(visit: (SimpleTree) -> Void) {
        visit(self)
        children.forEach { $0.depthFirstTraversal(visit: visit) }
    }
    
    // Traversal method: Breadth-First Search
    func breadthFirstTraversal(visit: (SimpleTree) -> Void) {
        var queue = [self]
        while !queue.isEmpty {
            let node = queue.removeFirst()
            visit(node)
            queue.append(contentsOf: node.children)
        }
    }
    
    // Pre-order Traversal
    func preOrderTraversal(visit: (SimpleTree) -> Void) {
        visit(self) // Visit the node itself first
        children.forEach { $0.preOrderTraversal(visit: visit) }
    }
    
    // Post-order Traversal
    func postOrderTraversal(visit: (SimpleTree) -> Void) {
        children.forEach { $0.postOrderTraversal(visit: visit) }
        visit(self) // Visit the node itself after all children
    }
    
    // In-order Traversal (generalized for an n-ary tree)
    func inOrderTraversal(visit: (SimpleTree) -> Void) {
        let middle = children.count / 2
        for i in 0..<middle {
            children[i].inOrderTraversal(visit: visit)
        }
        
        visit(self) // Visit the node itself in the "middle" of traversal
        
        for i in middle..<children.count {
            children[i].inOrderTraversal(visit: visit)
        }
    }
}


class BinaryTreeNode<K: Comparable> {
    var value: K
    var left: BinaryTreeNode<K>?
    var right: BinaryTreeNode<K>?
    
    init(value: K) {
        self.value = value
    }
}

class BinaryTree<K: Comparable> {
    var root: BinaryTreeNode<K>?
    
    init(rootValue: K) {
        root = BinaryTreeNode(value: rootValue)
    }
    
    // Add a new node to the tree
    func add(value: K) {
        guard let root = root else {
            self.root = BinaryTreeNode(value: value)
            return
        }
        addNode(root, value)
    }
    
    private func addNode(_ node: BinaryTreeNode<K>, _ value: K) {
        if value < node.value {
            if let left = node.left {
                addNode(left, value)
            } else {
                node.left = BinaryTreeNode(value: value)
            }
        } else {
            if let right = node.right {
                addNode(right, value)
            } else {
                node.right = BinaryTreeNode(value: value)
            }
        }
    }
    
    // Pre-order Traversal
    func preOrderTraversal(visit: (K) -> Void) {
        preOrderTraversalHelper(node: root, visit: visit)
    }
    
    private func preOrderTraversalHelper(node: BinaryTreeNode<K>?, visit: (K) -> Void) {
        guard let node = node else { return }
        visit(node.value) // Visit the node itself
        preOrderTraversalHelper(node: node.left, visit: visit) // Visit left subtree
        preOrderTraversalHelper(node: node.right, visit: visit) // Visit right subtree
    }
    
    // In-order Traversal
    func inOrderTraversal(visit: (K) -> Void) {
        inOrderTraversalHelper(node: root, visit: visit)
    }
    
    private func inOrderTraversalHelper(node: BinaryTreeNode<K>?, visit: (K) -> Void) {
        guard let node = node else { return }
        inOrderTraversalHelper(node: node.left, visit: visit) // Visit left subtree
        visit(node.value) // Visit the node itself
        inOrderTraversalHelper(node: node.right, visit: visit) // Visit right subtree
    }
    
    // Post-order Traversal
    func postOrderTraversal(visit: (K) -> Void) {
        postOrderTraversalHelper(node: root, visit: visit)
    }
    
    private func postOrderTraversalHelper(node: BinaryTreeNode<K>?, visit: (K) -> Void) {
        guard let node = node else { return }
        postOrderTraversalHelper(node: node.left, visit: visit) // Visit left subtree
        postOrderTraversalHelper(node: node.right, visit: visit) // Visit right subtree
        visit(node.value) // Visit the node itself
    }
    
    // Depth-First Search (DFS)
    func depthFirstSearch(visit: (K) -> Void) {
        dfsHelper(node: root, visit: visit)
    }
    
    private func dfsHelper(node: BinaryTreeNode<K>?, visit: (K) -> Void) {
        guard let node = node else { return }
        visit(node.value) // Visit the node
        dfsHelper(node: node.left, visit: visit) // Traverse left subtree
        dfsHelper(node: node.right, visit: visit) // Traverse right subtree
    }
    
    // Breadth-First Search (BFS)
    func breadthFirstSearch(visit: (K) -> Void) {
        guard let root = root else { return }
        var queue: [BinaryTreeNode<K>] = [root]
        
        while !queue.isEmpty {
            let node = queue.removeFirst()
            visit(node.value)
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
    }
}
