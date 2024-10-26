//
//  BSTs.swift
//  SwiftDSA
//
//  Created by Navneet Singh on 22/10/24.
//

class BSTNode<K: Comparable> {
    var key: K
    var left: BSTNode?
    var right: BSTNode?
    
    init(_ key: K) {
        self.key = key
    }
    
    var min: BSTNode {
        return left?.min ?? self
    }
}

class BST<K: Comparable> {
    var root: BSTNode<K>?

    // Insert a key into the BST
    func insert(key: K) {
        root = insertItem(root, key)
    }
    
    private func insertItem(_ node: BSTNode<K>?, _ key: K) -> BSTNode<K> {
        guard let node = node else {
            return BSTNode(key)
        }
        
        if key < node.key {
            node.left = insertItem(node.left, key)
        } else if key > node.key {
            node.right = insertItem(node.right, key)
        }
        
        return node // Ignore duplicate keys
    }
    
    // Find a key in the BST
    func find(key: K) -> BSTNode<K>? {
        return find(root, key)
    }

    private func find(_ node: BSTNode<K>?, _ key: K) -> BSTNode<K>? {
        guard let node = node else { return nil }
        
        if key == node.key {
            return node
        } else if key < node.key {
            return find(node.left, key)
        } else {
            return find(node.right, key)
        }
    }
    
    // Find the minimum key in the BST
    func findMin() -> K? {
        return root?.min.key
    }

    // Delete a key from the BST
    func delete(key: K) {
        root = delete(root, key)
    }
    
    private func delete(_ node: BSTNode<K>?, _ key: K) -> BSTNode<K>? {
        guard let nd = node else { return nil }

        if key < nd.key {
            nd.left = delete(nd.left, key)
        } else if key > nd.key {
            nd.right = delete(nd.right, key)
        } else {
            // Found the node to delete

            // Case 1: No child
            if nd.left == nil && nd.right == nil {
                return nil
            }
            
            // Case 2: One child
            if nd.left == nil {
                return nd.right
            } else if nd.right == nil {
                return nd.left
            }
            
            // Case 3: Two children
            let minRight = nd.right!.min
            nd.key = minRight.key
            nd.right = delete(nd.right, minRight.key)
        }
        
        return nd
    }

    // Pretty print the tree (hard-coded for depth = 3)
    func prettyPrint() {
        guard let root = root else {
            print("Tree is empty.")
            return
        }
        
        let rootLeftKey = root.left?.key ?? (0 as! K)
        let rootRightKey = root.right?.key ?? (0 as! K)
        let rootLeftLeftKey = root.left?.left?.key ?? (0 as! K)
        let rootLeftRightKey = root.left?.right?.key ?? (0 as! K)
        let rootRightLeftKey = root.right?.left?.key ?? (0 as! K)
        let rootRightRightKey = root.right?.right?.key ?? (0 as! K)
        
        let str = """
                      \(root.key)
                    /  \\
                   \(rootLeftKey)    \(rootRightKey)
                  / \\  / \\
                 \(rootLeftLeftKey)  \(rootLeftRightKey) \(rootRightLeftKey)   \(rootRightRightKey)
        """

        print(str)
    }
    
    // In-Order Traversal
    func printInOrderTraversal() { inOrderTraversal(node: root) }
    
    private func inOrderTraversal(node: BSTNode<K>?) {
        guard let node = node else { return }
        inOrderTraversal(node: node.left)
        print(node.key) // root
        inOrderTraversal(node: node.right)
    }
    
    // Pre-Order Traversal
    func printPreOrderTraversal() { preOrderTraversal(node: root) }
    
    private func preOrderTraversal(node: BSTNode<K>?) {
        guard let node = node else { return }
        print(node.key) // root
        preOrderTraversal(node: node.left)
        preOrderTraversal(node: node.right)
    }

    // Post-Order Traversal
    func printPostOrderTraversal() { postOrderTraversal(node: root) }
    
    private func postOrderTraversal(node: BSTNode<K>?) {
        guard let node = node else { return }
        postOrderTraversal(node: node.left)
        postOrderTraversal(node: node.right)
        print(node.key) // root
    }
}
