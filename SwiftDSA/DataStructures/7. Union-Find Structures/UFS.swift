//
//  UFS.swift
//  SwiftDSA
//
//  Created by Navneet Singh on 22/10/24.
//

class UnionFind<T: Hashable> {
    private var parent: [T: T] = [:]   // Tracks the parent of each element
    private var rank: [T: Int] = [:]     // Tracks the rank (depth) of trees
    private var size: [T: Int] = [:]     // Tracks the size of each set
    
    // Find the representative (root) of the set that contains element x
    func find(_ x: T) -> T {
        if parent[x] == nil {
            parent[x] = x // Initialize parent to itself if not already set
            rank[x] = 0    // Initialize rank to 0
            size[x] = 1    // Initialize size to 1
        }
        
        if parent[x] != x {
            parent[x] = find(parent[x]!) // Path compression
        }
        return parent[x]!
    }

    // Union the sets that contain x and y
    func union(_ x: T, _ y: T) {
        let rootX = find(x)
        let rootY = find(y)

        if rootX != rootY {
            // Union by rank
            if rank[rootX]! < rank[rootY]! {
                parent[rootX] = rootY
                size[rootY]! += size[rootX]!
            } else if rank[rootX]! > rank[rootY]! {
                parent[rootY] = rootX
                size[rootX]! += size[rootY]!
            } else {
                parent[rootY] = rootX
                size[rootX]! += size[rootY]!
                rank[rootX]! += 1
            }
        }
    }

    // Check if x and y are in the same set
    func connected(_ x: T, _ y: T) -> Bool {
        return find(x) == find(y)
    }
    
    // Get the number of disjoint sets
    func countSets() -> Int {
        var roots = Set<T>()
        for key in parent.keys {
            roots.insert(find(key))
        }
        return roots.count
    }
    
    // Get the size of the set containing x
    func sizeOfSet(_ x: T) -> Int {
        let root = find(x)
        return size[root] ?? 0
    }
    
    // Get all elements in the set containing x
    func elementsInSet(_ x: T) -> [T] {
        let root = find(x)
        return parent.keys.filter { find($0) == root }
    }
    
    // Reset the Union-Find structure
    func reset() {
        parent.removeAll()
        rank.removeAll()
        size.removeAll()
    }
    
    // Get all disjoint sets as arrays
    func allDisjointSets() -> [[T]] {
        var sets: [[T]] = []
        var seen = Set<T>()

        for key in parent.keys {
            let root = find(key)
            if !seen.contains(root) {
                seen.insert(root)
                sets.append(elementsInSet(root))
            }
        }
        return sets
    }
    
    // List all elements in the Union-Find structure
    func allElements() -> [T] {
        return Array(parent.keys)
    }
}

