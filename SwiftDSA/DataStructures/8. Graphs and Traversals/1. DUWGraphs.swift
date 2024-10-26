//
//  DUWGraphs.swift
//  SwiftDSA
//
//  Created by Navneet Singh on 22/10/24.
//

class DUWGraph {
    var V = 0                       // number of vertices
    var adj = [[Int]]()             // adjacency list
    
    init(_ V: Int) {
        self.V = V
        for _ in 0..<V {
            adj.append([Int]())     // create empty array of adjacency lists
        }
    }
    
    // Add an edge from vertex v to vertex w
    func addEdge(v: Int, w: Int) {
        adj[v].append(w)
    }
    
    // Remove an edge from vertex v to vertex w
    func removeEdge(v: Int, w: Int) {
        adj[v].removeAll(where: { $0 == w })
    }
    
    // Check if there is an edge from vertex v to vertex w
    func hasEdge(v: Int, w: Int) -> Bool {
        return adj[v].contains(w)
    }
    
    // Get all neighbors of vertex v
    func getNeighbors(v: Int) -> [Int] {
        return adj[v]
    }
    
    // Get the out-degree of a vertex
    func outDegree(v: Int) -> Int {
        return adj[v].count
    }
    
    // Get the in-degree of a vertex
    func inDegree(v: Int) -> Int {
        var count = 0
        for neighbors in adj {
            if neighbors.contains(v) {
                count += 1
            }
        }
        return count
    }
    
    // BFS traversal from a given source s
    func BFS(s: Int) -> [Int] {
        var result = [Int]()
        var visited = adj.map { _ in false }
        var queue = GQueue<Int>()
        
        visited[s] = true
        print("Starting at \(s)")
        queue.add(s)
        result.append(s)
        
        while queue.count > 0 {
            let current = queue.remove()!
            print("De-queueing \(current)")
            
            for n in adj[current] {
                if visited[n] == false {
                    visited[n] = true
                    print("Queuing \(n)")
                    queue.add(n)
                    result.append(n)
                }
            }
        }
        
        return result
    }
    
    // DFS traversal from a given source s
    func DFS(s: Int) -> [Int] {
        var result = [Int]()
        var visited = adj.map { _ in false }
        var stack = GStack<Int>()
        
        print("Starting at \(s)")
        visited[s] = true
        stack.push(s)
        
        while stack.count > 0 {
            let current = stack.pop()!
            print("Popping \(current)")
            result.append(current)
            
            for n in adj[current] {
                if visited[n] == false {
                    visited[n] = true
                    print("Pushing - \(n)")
                    stack.push(n)
                }
            }
        }
        
        return result
    }
}
