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
