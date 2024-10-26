//
//  Tries.swift
//  SwiftDSA
//
//  Created by Navneet Singh on 27/10/24.
//

class TrieNode<T: Hashable> {
    var children: [T: TrieNode] = [:]
    var isEndOfWord: Bool = false // Indicates if a word ends at this node
    
    init() {}
}

class Trie<T: Hashable> {
    private var root: TrieNode<T> = TrieNode()

    // Insert a word into the Trie
    func insert(_ word: [T]) {
        var currentNode = root
        
        for character in word {
            if currentNode.children[character] == nil {
                currentNode.children[character] = TrieNode()
            }
            currentNode = currentNode.children[character]!
        }
        currentNode.isEndOfWord = true
    }

    // Search for a word in the Trie
    func search(_ word: [T]) -> Bool {
        let node = findNode(word)
        return node != nil && node!.isEndOfWord
    }

    // Search for a prefix in the Trie
    func startsWith(_ prefix: [T]) -> Bool {
        return findNode(prefix) != nil
    }

    // Delete a word from the Trie
    func delete(_ word: [T]) {
        _ = deleteHelper(root, word, 0)
    }

    // Get all words in the Trie with a given prefix
    func wordsWithPrefix(_ prefix: [T]) -> [[T]] {
        var result: [[T]] = []
        let node = findNode(prefix)
        if node != nil {
            var currentWord = prefix
            findWords(node: node!, currentWord: &currentWord, result: &result)
        }
        return result
    }

    // Check if the Trie is empty
    func isEmpty() -> Bool {
        return root.children.isEmpty
    }

    // Get the count of words in the Trie
    func countWords() -> Int {
        return countWordsHelper(node: root)
    }

    // Get the total number of nodes in the Trie (for debugging)
    func totalNodes() -> Int {
        return totalNodesHelper(node: root)
    }

    // Private helper methods
    private func findNode(_ word: [T]) -> TrieNode<T>? {
        var currentNode = root
        
        for character in word {
            if let nextNode = currentNode.children[character] {
                currentNode = nextNode
            } else {
                return nil
            }
        }
        return currentNode
    }

    private func deleteHelper(_ node: TrieNode<T>, _ word: [T], _ index: Int) -> Bool {
        if index == word.count {
            if node.isEndOfWord {
                node.isEndOfWord = false
                return node.children.isEmpty // Return true if no children
            }
            return false // Word not found
        }

        let character = word[index]
        guard let childNode = node.children[character] else {
            return false // Word not found
        }

        let shouldDeleteChildNode = deleteHelper(childNode, word, index + 1)

        if shouldDeleteChildNode {
            node.children[character] = nil
            return node.children.isEmpty && !node.isEndOfWord
        }

        return false
    }

    private func findWords(node: TrieNode<T>, currentWord: inout [T], result: inout [[T]]) {
        if node.isEndOfWord {
            result.append(currentWord)
        }
        
        for (character, childNode) in node.children {
            currentWord.append(character)
            findWords(node: childNode, currentWord: &currentWord, result: &result)
            currentWord.removeLast() // Backtrack
        }
    }

    private func countWordsHelper(node: TrieNode<T>) -> Int {
        var count = node.isEndOfWord ? 1 : 0

        for childNode in node.children.values {
            count += countWordsHelper(node: childNode)
        }
        return count
    }

    private func totalNodesHelper(node: TrieNode<T>) -> Int {
        var count = 1 // Count this node

        for childNode in node.children.values {
            count += totalNodesHelper(node: childNode)
        }
        return count
    }
}
