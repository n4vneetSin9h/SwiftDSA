//
//  AVLTrees.swift
//  SwiftDSA
//
//  Created by Navneet Singh on 22/10/24.
//

class AVLNode<K: Comparable> {
    var key: K
    var left: AVLNode?
    var right: AVLNode?
    var height: Int

    init(_ key: K) {
        self.key = key
        self.height = 1 // New node is initially added at leaf
    }
}

class AVLTree<K: Comparable> {
    var root: AVLNode<K>?

    // Function to get the height of the node
    private func height(_ node: AVLNode<K>?) -> Int {
        return node?.height ?? 0
    }

    // Function to get the balance factor of the node
    private func getBalance(_ node: AVLNode<K>?) -> Int {
        return height(node?.left) - height(node?.right)
    }

    // Right rotate subtree rooted with y
    private func rightRotate(_ y: AVLNode<K>) -> AVLNode<K> {
        let x = y.left!
        let T2 = x.right
        
        // Perform rotation
        x.right = y
        y.left = T2
        
        // Update heights
        y.height = max(height(y.left), height(y.right)) + 1
        x.height = max(height(x.left), height(x.right)) + 1
        
        return x // New root
    }

    // Left rotate subtree rooted with x
    private func leftRotate(_ x: AVLNode<K>) -> AVLNode<K> {
        let y = x.right!
        let T2 = y.left
        
        // Perform rotation
        y.left = x
        x.right = T2
        
        // Update heights
        x.height = max(height(x.left), height(x.right)) + 1
        y.height = max(height(y.left), height(y.right)) + 1
        
        return y // New root
    }

    // Insert a key in the subtree rooted with node and returns the new root of the subtree
    func insert(key: K) {
        root = insert(root, key)
    }

    private func insert(_ node: AVLNode<K>?, _ key: K) -> AVLNode<K> {
        // Perform the normal BST insert
        guard let node = node else {
            return AVLNode(key)
        }
        
        if key < node.key {
            node.left = insert(node.left, key)
        } else if key > node.key {
            node.right = insert(node.right, key)
        } else {
            // Duplicates are not allowed
            return node
        }
        
        // Update the height of this ancestor node
        node.height = 1 + max(height(node.left), height(node.right))
        
        // Get the balance factor
        let balance = getBalance(node)
        
        // If the node becomes unbalanced, then there are 4 cases
        
        // Left Left Case
        if balance > 1 && key < node.left!.key {
            return rightRotate(node)
        }
        
        // Right Right Case
        if balance < -1 && key > node.right!.key {
            return leftRotate(node)
        }
        
        // Left Right Case
        if balance > 1 && key > node.left!.key {
            node.left = leftRotate(node.left!)
            return rightRotate(node)
        }
        
        // Right Left Case
        if balance < -1 && key < node.right!.key {
            node.right = rightRotate(node.right!)
            return leftRotate(node)
        }
        
        return node // Return the (unchanged) node pointer
    }

    // Delete a key from the AVL tree
    func delete(key: K) {
        root = delete(root, key)
    }

    private func delete(_ node: AVLNode<K>?, _ key: K) -> AVLNode<K>? {
        guard let node = node else {
            return nil
        }

        // Perform standard BST delete
        if key < node.key {
            node.left = delete(node.left, key)
        } else if key > node.key {
            node.right = delete(node.right, key)
        } else {
            // Node with only one child or no child
            if node.left == nil {
                return node.right
            } else if node.right == nil {
                return node.left
            }
            
            // Node with two children: Get the inorder successor (smallest in the right subtree)
            let temp = minValueNode(node.right!)
            node.key = temp.key
            
            // Delete the inorder successor
            node.right = delete(node.right, temp.key)
        }

        // Check if the tree had only one node then return
        if node.left == nil && node.right == nil {
            return nil // Tree is empty after deletion
        }
        
        // Update height of the current node
        node.height = 1 + max(height(node.left), height(node.right))
        
        // Get the balance factor
        let balance = getBalance(node)
        
        // If the node becomes unbalanced, then there are 4 cases

        // Left Left Case
        if balance > 1 && getBalance(node.left) >= 0 {
            return rightRotate(node)
        }

        // Left Right Case
        if balance > 1 && getBalance(node.left) < 0 {
            node.left = leftRotate(node.left!)
            return rightRotate(node)
        }

        // Right Right Case
        if balance < -1 && getBalance(node.right) <= 0 {
            return leftRotate(node)
        }

        // Right Left Case
        if balance < -1 && getBalance(node.right) > 0 {
            node.right = rightRotate(node.right!)
            return leftRotate(node)
        }

        return node
    }

    // Function to get the node with minimum key value
    private func minValueNode(_ node: AVLNode<K>) -> AVLNode<K> {
        var current = node
        while current.left != nil {
            current = current.left!
        }
        return current
    }

    // In-Order Traversal
    func printInOrderTraversal() {
        inOrderTraversal(node: root)
    }

    private func inOrderTraversal(node: AVLNode<K>?) {
        guard let node = node else { return }
        inOrderTraversal(node: node.left)
        print(node.key)
        inOrderTraversal(node: node.right)
    }
    
    // Pre-Order Traversal
    func printPreOrderTraversal() {
        preOrderTraversal(node: root)
    }

    private func preOrderTraversal(node: AVLNode<K>?) {
        guard let node = node else { return }
        print(node.key)
        preOrderTraversal(node: node.left)
        preOrderTraversal(node: node.right)
    }

    // Post-Order Traversal
    func printPostOrderTraversal() {
        postOrderTraversal(node: root)
    }

    private func postOrderTraversal(node: AVLNode<K>?) {
        guard let node = node else { return }
        postOrderTraversal(node: node.left)
        postOrderTraversal(node: node.right)
        print(node.key)
    }
}

